//
//  Listener.swift
//  task3_app
//
//  Created by Özgür  Atak  on 29.08.2023.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(callback: @escaping (T) -> Void) {
        self.listener = callback
    }
    
    init(_ value: T) {
        self.value = value
    }
    
}

struct LoginViewModel {
    var userName = Dynamic("")
    var password = Dynamic("")
}
