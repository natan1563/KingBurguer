//
//  TextField.swift
//  KingBurguer
//
//  Created by Natã Romão on 16/03/23.
//

import Foundation
import UIKit

protocol TextFieldDelegate: UITextFieldDelegate {
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String)
}

class TextField: UIView {
    
    lazy var ed: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let errorLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var maskField: Mask?
    
    var bitmask: Int = 0
    
    var placeholder: String? {
        willSet {
            ed.placeholder = newValue
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        willSet {
            if newValue == .emailAddress {
                ed.autocapitalizationType = .none
            }
            ed.keyboardType = newValue
        }
    }
    
    var secureTextEntry: Bool = false {
        willSet {
            ed.isSecureTextEntry = newValue
            ed.textContentType = .oneTimeCode
        }
    }
    
    var delegate: TextFieldDelegate? {
        willSet {
            ed.delegate = newValue
        }
    }
    
    var text: String {
        get {
            return ed.text!
        }
    }
    
    override var tag: Int {
        willSet {
            super.tag = newValue
            ed.tag = newValue
        }
    }
    
    var returnKeyType: UIReturnKeyType = .next {
        willSet {
            ed.returnKeyType = newValue
        }
    }
    
    var failure: ( () -> Bool )?
    
    var error: String?
    
    var heightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(ed)
        addSubview(errorLabel)
        
        let edConstraints = [
            ed.leadingAnchor.constraint(equalTo: leadingAnchor),
            ed.trailingAnchor.constraint(equalTo: trailingAnchor),
            ed.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let errorLabelConstraints = [
            errorLabel.leadingAnchor.constraint(equalTo: ed.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: ed.trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: ed.bottomAnchor),
        ]
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate(edConstraints)
        NSLayoutConstraint.activate(errorLabelConstraints)
    }
    
    func gainFocus() {
        ed.becomeFirstResponder()
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        if let mask = maskField {
            if let res = mask.process(value: textField.text!) {
                textField.text = res
            }
        }
        
        guard let f = failure else { return }
       
        if let error = error {
            if f() {
                errorLabel.text = error
                heightConstraint.constant = 70
                delegate?.textFieldDidChanged(isValid: false, bitmask: bitmask, text: textField.text!)
            } else {
                errorLabel.text = ""
                heightConstraint.constant = 50
                delegate?.textFieldDidChanged(isValid: true, bitmask: bitmask, text: textField.text!)
            }
        }
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
