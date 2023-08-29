//
//  ViewController.swift
//  task3_app
//
//  Created by Özgür  Atak  on 29.08.2023.
//

import UIKit

class ViewController: UIViewController {
    private var timeVM = TimeViewModel()
    
    lazy var timeTextField: UITextField = {
        let timeTextField = BindingTextField()
        timeTextField.layer.maskedCorners
        timeTextField.layer.borderWidth = 2
        
        timeTextField.bind { [weak self] text in
            self?.timeVM.time().value = text
        }
        return timeTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeVM.time().bind { text in
            self.timeTextField.text = text
        }
        
        setupUI()
    }
    
    @objc func startButtonAction() {
        
    }
    
    @objc func resetButtonAction() {
        
    }
    
    private func setupUI() {
        let timePickerView = UIPickerView()
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        let startButton = UIButton()
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
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [timePickerView, self.timeTextField, startButton, resetButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }


}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    

    
    
}

