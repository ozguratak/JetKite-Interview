//
//  NotificationCOntroller.swift
//  task3_app
//
//  Created by Özgür  Atak  on 30.08.2023.
//

import Foundation
import UIKit
class NotificationViewController {
    
    static func alert(alertInfo: String, page: UIViewController) {
        let alertVC = UIAlertController(title: "Success!", message: alertInfo, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Done!", style: .default) { action in
          page.navigationController?.popViewController(animated: true)
        }
        alertVC.addAction(okButton)
        page.present(alertVC, animated: true)
    }
    
    static func alarmDismissed(page: UIViewController) {
        let alertVC = UIAlertController(title: "Alarm!", message: "Please press Silent button for dismiss your alert.", preferredStyle: .alert)
        
        let dismissButton = UIAlertAction(title: "Silent", style: .default) { action in
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            AppDelegate().alertSetted = false
            page.navigationController?.popViewController(animated: true)
        }
        
        alertVC.addAction(dismissButton)
        page.present(alertVC, animated: true)
    }
}
