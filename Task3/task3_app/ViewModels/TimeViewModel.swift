//
//  TimeViewModel.swift
//  task3_app
//
//  Created by Özgür  Atak  on 29.08.2023.
//

import Foundation
class TimeViewModel: NotificationManagerProtocol {
    
    var counterSeconds = Dynamic("0")

        
    func alarmDidSaved() {
        NotificationManager.scheduleAlarm(timeModel: self)
    }
    
    func removeAlarm() {
        NotificationManager.center.removeAllPendingNotificationRequests()
        print("Planlanmış alarmlar iptal edildi!")
    }
 
    
   
}
