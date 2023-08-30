//
//  NotificaitonManager.swift
//  task3_app
//
//  Created by Özgür  Atak  on 30.08.2023.
//

import Foundation
import UserNotifications

protocol NotificationManagerProtocol {
    func alarmDidSaved()
    func removeAlarm()
}

class NotificationManager: UNUserNotificationCenter, UNUserNotificationCenterDelegate {
    static let center = UNUserNotificationCenter.current()
    
    static func scheduleAlarm(timeModel: TimeViewModel) {
       
        if let seconds = Int(timeModel.counterSeconds.value) {
            
            let content = UNMutableNotificationContent()
            content.title = "Alarm"
            content.body = "Wake Up!"
            content.sound = UNNotificationSound.defaultCritical
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(seconds), repeats: false)
            
            let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
            
            self.center.add(request) { (error) in
                if let error = error {
                    print("Bildirim hatası: \(error.localizedDescription)")
                } else {
                    print("Alarm başarıyla planlandı. Alarm Süresi \(seconds) saniye")
                    AppDelegate().alertSetted = true
                }
            }
        }
    }
    
}
