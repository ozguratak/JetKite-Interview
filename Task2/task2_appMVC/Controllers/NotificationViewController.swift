//
//  NotificationController.swift
//  task2_appMVC
//
//  Created by Özgür  Atak  on 28.08.2023.
//

import Foundation
import UIKit
class NotificationViewController {
    
    static func alert(alertInfo: String, page: UIViewController) {
        let alertVC = UIAlertController(title: "Alarm!", message: alertInfo, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Done!", style: .default) { action in
            page.navigationController?.popViewController(animated: true)
        }
        alertVC.addAction(okButton)
        page.present(alertVC, animated: true)
    }
}
