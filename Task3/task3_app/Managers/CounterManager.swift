//
//  CounterManager.swift
//  task3_app
//
//  Created by Özgür  Atak  on 30.08.2023.
//

import Foundation
class CounterManager {
    private var counterRemaining: Int?
    private var timer: Timer?
    
    func countdown(timeModel: TimeViewModel, state: TimerState, updateHandler: @escaping (Int) -> Void, completion: @escaping () -> Void) {
        
        if let time = Int(timeModel.counterSeconds.value) {
            switch state {
            case .start:
                var remainingTime = time
                timeModel.alarmDidSaved()
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    updateHandler(remainingTime)
                    if remainingTime > 0 {
                        remainingTime -= 1
                        
                        timeModel.counterSeconds.value = String(remainingTime)
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
                if let remaining = Int(timeModel.counterSeconds.value) {
                    timeModel.removeAlarm()
                    self.counterRemaining = remaining
                    timeModel.counterSeconds.value = String(describing: remaining)
                    timer?.invalidate()
                    updateHandler(remaining)
                    completion()
                }
            case .reset:
                timeModel.removeAlarm()
                timer?.invalidate()
                timeModel.counterSeconds.value = "0"
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

    


