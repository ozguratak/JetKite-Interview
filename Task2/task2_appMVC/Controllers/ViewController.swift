//
//  ViewController.swift
//  task2_appMVC
//
//  Created by Özgür  Atak  on 28.08.2023.
//

import UIKit

class ViewController: UIViewController, LocalServiceProtocol {
    func alarmDismissedFromNotification() {
        NotificationViewController.alarmDismissed(page: self)
    }
    func alarmDidSaved() {
        NotificationViewController.alert(alertInfo: "Alert has setted for \(vm.calculateAlarmTime()) minutes", page: self)
    }
    
    let hours = Array(0...23)
    let minutes = Array(0...59)
    private var vm = TimeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
   
    @objc func setAlarm(){
        vm.setTimer() 
        alarmDidSaved()
    }

    func setupUI() {
        let header = UILabel()
        header.text = "Set Alarm Time"
        header.textColor = UIColor.black
        header.textAlignment = .center
        
        let timePicker = UIPickerView()
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.showsLargeContentViewer = true
        timePicker.widthAnchor.constraint(equalToConstant: 150).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        timePicker.dataSource = self
        timePicker.delegate = self
        
        let button = UIButton()
        button.backgroundColor = UIColor.systemBlue
        button.setTitle("Set Alarm", for: .normal)
        button.addTarget(self, action: #selector(setAlarm), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [header, timePicker, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
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
        if component == 0 {
            return hours.count
        } else {
            return minutes.count
        }
    }

    // UIPickerViewDelegate protokolünün gerektirdiği yöntemler
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(hours[row])"
        } else {
            return "\(minutes[row])"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.vm.model.hours = hours[pickerView.selectedRow(inComponent: 0)]
        self.vm.model.minutes = minutes[pickerView.selectedRow(inComponent: 1)]
    }
}

