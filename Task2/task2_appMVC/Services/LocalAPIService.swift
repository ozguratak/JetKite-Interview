//
//  LocalAPIService.swift
//  task2_appMVC
//
//  Created by Özgür  Atak  on 28.08.2023.
//

import Foundation
import UserNotifications
import UIKit

protocol LocalServiceProtocol {
    func alarmDidSaved()
    func alarmDismissedFromNotification()
}

class LocalService: UNUserNotificationCenter, UNUserNotificationCenterDelegate {
    static func scheduleAlarm(timeModel: TimeViewModel) {
        let center = UNUserNotificationCenter.current()
        
        if let hours = timeModel.model.hours, let minutes = timeModel.model.minutes {
            
            let totalMinutes = (hours * 60) + minutes
            
            let content = UNMutableNotificationContent()
            content.title = "Alarm"
            content.body = "Wake Up!"
            content.sound = UNNotificationSound.defaultCritical
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(totalMinutes * 10), repeats: false)
            
            let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
            
            center.add(request) { (error) in
                if let error = error {
                    print("Bildirim hatası: \(error.localizedDescription)")
                } else {
                    print("Alarm başarıyla planlandı. Alarm Süresi \(hours) saat, \(minutes) dakika")
                    AppDelegate().alertSetted = true
                }
            }
        }
    }
    
}

