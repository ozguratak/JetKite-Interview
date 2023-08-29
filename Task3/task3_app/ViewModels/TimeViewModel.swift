//
//  TimeViewModel.swift
//  task3_app
//
//  Created by Özgür  Atak  on 29.08.2023.
//

import Foundation
struct TimeViewModel {
    var minutes = Dynamic(0)
    var seconds = Dynamic(0)
    
    func time() -> Dynamic<String> {
        return Dynamic(String(describing: minutes) + " : " + String(describing: seconds))
    }
}
