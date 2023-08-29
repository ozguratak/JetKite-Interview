//
//  ViewModel2ViewBinding.swift
//  task3_app
//
//  Created by Özgür  Atak  on 29.08.2023.
//

import Foundation
import UIKit

class BindingTextField: UITextField{

    var textChanged: (String) -> Void = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func bind(callback: @escaping (String) -> Void) {
        textChanged = callback
    }
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        if let text = textfield.text {
            textChanged(text)
        }
    }
}
