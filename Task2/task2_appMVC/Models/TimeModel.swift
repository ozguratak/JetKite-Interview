//
//  TimeModel.swift
//  task2_appMVC
//
//  Created by Özgür  Atak  on 28.08.2023.
//

import Foundation

struct TimeModel: Codable{
    var hours: Int?
    var minutes: Int?
}

extension TimeModel {
    init(_ time: TimeModel) {
        var hour = time.hours
        var minutes = time.minutes
    }
}

extension TimeModel {
    mutating func setTime(time: TimeModel) {
        hours = time.hours
        minutes = time.minutes
        
        print(TimeModel())
    }
}
