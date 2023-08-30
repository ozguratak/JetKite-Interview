//
//  TimeViewModel.swift
//  task3_app
//
//  Created by Özgür  Atak  on 29.08.2023.
//

import Foundation
class TimeViewModel: NotificationManagerProtocol {
    
    var counterSeconds = Dynamic("0")
    private var counterRemaining: Int?
    var currentAction: String?
    private var timer: Timer?
        
    func alarmDidSaved() {
        NotificationManager.scheduleAlarm(timeModel: self)
    }
    
    func removeNotification() {
        NotificationManager.center.removeAllPendingNotificationRequests()
        print("Planlanmış alarmlar iptal edildi!")
    }
 
    
    func countdown(state: TimerState, updateHandler: @escaping (Int) -> Void, completion: @escaping () -> Void) {
        currentAction = state.rawValue
        if let time = Int(counterSeconds.value) {
            switch state {
            case .start:
                var remainingTime = time
                self.alarmDidSaved()
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    updateHandler(remainingTime)
                    if remainingTime > 0 {
                        remainingTime -= 1
                        self.counterSeconds.value = String(remainingTime)
                    } else {
                        timer.invalidate()
                        completion()
                    }
                }
                if let timer = timer {
                    timer.fire()
                } else {
                    fatalError("Timer was not found!")
                }
            case .pause:
                if let remaining = Int(self.counterSeconds.value) {
                    self.removeNotification()
                    self.counterRemaining = remaining
                    self.counterSeconds.value = String(describing: remaining)
                    timer?.invalidate()
                    updateHandler(remaining)
                    completion()
                }
            case .reset:
                self.removeNotification()
                timer?.invalidate()
                self.counterSeconds.value = "0"
                self.counterRemaining = nil
                completion()
            }
        }
    }
    
}
enum TimerState: String, CaseIterable {
    case start = "Start"
    case pause = "Pause"
    case reset = "Reset"
}
