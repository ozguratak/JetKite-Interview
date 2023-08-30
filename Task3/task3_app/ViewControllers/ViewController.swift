//
//  ViewController.swift
//  task3_app
//
//  Created by Özgür  Atak  on 29.08.2023.
//

import UIKit

class ViewController: UIViewController {
    private let pickerViewData = Array(0...59)
    private var timeVM = TimeViewModel()
    let timePickerView = UIPickerView()
    let startButton = UIButton()
    
    lazy var timeTextField: UITextField = {
        let timeTextField = BindingTextField()
        timeTextField.layer.borderWidth = 2
        timeTextField.textAlignment = .center
        timeTextField.placeholder = "Create time"
        
        timeTextField.bind { [weak self] text in
            self?.timeVM.counterSeconds.value = text
        }
        return timeTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeVM.counterSeconds.bind { text in
            self.timeTextField.text = text
        }
        
        setupUI()
    }
    
    @objc func startButtonAction() {
        switch startButton.title(for: .normal) {
        case "Pause":
            timeVM.countdown(state: .pause) { remainingTime in
                self.timeTextField.text = "Paused at \(remainingTime)"
                self.startButton.backgroundColor = UIColor.systemGreen
                self.startButton.setTitle("Resume", for: .normal)
            } completion: {
                self.startButton.backgroundColor = UIColor.systemGreen
                self.startButton.setTitle("Resume", for: .normal)
            }
        default:
            timeVM.countdown(state: .start) { secondsRemaining in
                self.timeTextField.text = "\(secondsRemaining)"
                self.startButton.backgroundColor = UIColor.systemRed
                self.startButton.setTitle("Pause", for: .normal)
            } completion: {
                self.timeTextField.text = "Timer has elapsed!"
                self.startButton.setTitle("Start", for: .normal)
                self.startButton.backgroundColor = UIColor.systemGreen
            }
        }

    }
    
    @objc func resetButtonAction() {
        DispatchQueue.main.async {
            self.timeVM.countdown(state: .reset) { remainingTime in
                self.timeTextField.text = "Counter Reset"
                self.startButton.backgroundColor = UIColor.systemGreen
                self.startButton.setTitle("Start", for: .normal)
            } completion: {
                self.startButton.backgroundColor = UIColor.systemGreen
                self.startButton.setTitle("Start", for: .normal)
            }
        }
    }
    
    private func setupUI() {
        let minutes = UILabel()
        minutes.text = "Minutes"
        
        let seperator = UILabel()
        seperator.text = ":"
        
        let second = UILabel()
        second.text = "Second"
        
        let headersStackView = UIStackView(arrangedSubviews: [minutes, seperator, second])
        headersStackView.axis = .horizontal
        headersStackView.distribution = .equalSpacing
        headersStackView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        headersStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.timePickerView.delegate = self
        self.timePickerView.dataSource = self
        self.timePickerView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        self.timePickerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = UIColor.systemGreen
        startButton.layer.cornerRadius = 12
        startButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        let resetButton = UIButton()
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = UIColor.systemRed
        resetButton.layer.cornerRadius = 12
        resetButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
   
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [headersStackView, timePickerView, self.timeTextField, startButton, resetButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }

    // UIPickerViewDelegate protokolünün gerektirdiği yöntemler
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerViewData[row])"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.timeTextField.text = String(describing:(pickerViewData[pickerView.selectedRow(inComponent: 0)] * 60) + (pickerViewData[pickerView.selectedRow(inComponent: 1)]))
        self.timeVM.counterSeconds.value = String(describing:(pickerViewData[pickerView.selectedRow(inComponent: 0)] * 60) + (pickerViewData[pickerView.selectedRow(inComponent: 1)]))
        
    }
}

