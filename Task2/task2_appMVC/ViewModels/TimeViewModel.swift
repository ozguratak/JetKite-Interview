//
//  TimeViewModel.swift
//  task2_appMVC
//
//  Created by Özgür  Atak  on 28.08.2023.
//

import Foundation

class TimeViewModel {
    var model = TimeModel()
    
    func setTimer() {
        LocalService.scheduleAlarm(timeModel: self)
    }
    
    func calculateAlarmTime() -> Int {
        if let hours = model.hours, let minutes = model.minutes {
            return (hours * 60) + minutes
        } else {
            return 0
        }
    }
    
}
