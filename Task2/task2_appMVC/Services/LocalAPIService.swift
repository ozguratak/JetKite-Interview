//
//  LocalAPIService.swift
//  task2_appMVC
//
//  Created by Özgür  Atak  on 28.08.2023.
//

import Foundation
import UserNotifications

protocol LocalServiceProtocol {
    func alarmDidSaved()
}

class LocalService {
    static func scheduleAlarm(timeModel: TimeModel) {
        let center = UNUserNotificationCenter.current()
        
        // Saat ve dakika değerlerini al
        if let hours = timeModel.hours, let minutes = timeModel.minutes {
            // Saat ve dakika değerlerini dakika cinsinden topla
            let totalMinutes = (hours * 60) + minutes
            
            // Bildirim içeriği oluşturma
            let content = UNMutableNotificationContent()
            content.title = "Alarm"
            content.body = "Wake Up!"
            content.sound = UNNotificationSound.default // Sesli bildirim
            
            // Bildirimi tetikleyen zaman aralığını oluştur
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(totalMinutes * 60), repeats: false)
            
            // Bildirimi tetikleyen bir istek oluştur
            let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
            
            // Bildirimi planlama
            center.add(request) { (error) in
                if let error = error {
                    print("Bildirim hatası: \(error.localizedDescription)")
                } else {
                    print("Alarm başarıyla planlandı. Alarm Süresi \(hours) saat, \(minutes) dakika")
                }
            }
        }
    }
    
}
