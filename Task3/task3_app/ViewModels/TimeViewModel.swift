//
//  TimeViewModel.swift
//  task3_app
//
//  Created by Özgür  Atak  on 29.08.2023.
//

import Foundation
class TimeViewModel {
    var counterSeconds = Dynamic("")
    
    func startCountdown(seconds: Int, updateHandler: @escaping (Int) -> Void, completion: @escaping () -> Void) {
        var remainingTime = seconds
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            updateHandler(remainingTime)
            
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer.invalidate()
                completion()
            }
        }
        
        // Timer'ı çalıştır
        timer.fire()
    }


}
