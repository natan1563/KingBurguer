//
//  SignUpViewController.swift
//  KingBurguer
//
//  Created by Natã Romão on 22/11/22.
//

import Foundation
import UIKit

enum SignUpForm: Int {
    case name     = 0x1
    case email    = 0x2
    case password = 0x4
    case document = 0x8
    case birthday = 0x10
}

class SignUpViewController: UIViewController {
    
    let scroll: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var name: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu nome"
        ed.tag = 1
        ed.bitmask = SignUpForm.name.rawValue
        ed.returnKeyType = .next
        ed.delegate = self
        ed.error = "Nome deve ter no minimo 3 caracteres"
        ed.failure = {
            return ed.text.count < 3
        }
        return ed
    }()
    
    lazy var email: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu e-mail"
        ed.tag = 2
        ed.bitmask = SignUpForm.email.rawValue
        ed.returnKeyType = .next
        ed.keyboardType = .emailAddress
        ed.delegate = self
        ed.error = "E-mail invalido"
        ed.failure = {
            return !ed.text.isEmail()
        }
        return ed
    }()
    
    lazy var password: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua senha"
        ed.tag = 3
        ed.bitmask = SignUpForm.password.rawValue
        ed.returnKeyType = .next
        ed.secureTextEntry = true
        ed.delegate = self
        ed.error = "Nome deve ter no minimo 8 caracteres"
        ed.failure = {
            return ed.text.count < 8
        }
        return ed
    }()
    
    lazy var document: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu CPF"
        ed.tag = 4
        ed.maskField = Mask(mask: "###.###.###-##")
        ed.bitmask = SignUpForm.document.rawValue
        ed.returnKeyType = .next
        ed.keyboardType = .numberPad
        ed.delegate = self
        ed.error = "CPF deve ter no minimo 11 digitos"
        ed.failure = {
            return ed.text.count != 14
        }
        return ed
    }()
    
    lazy var birthday: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu data de nascimento"
        ed.tag = 5
        ed.maskField = Mask(mask: "##/##/####")
        ed.bitmask = SignUpForm.birthday.rawValue
        ed.returnKeyType = .done
        ed.keyboardType = .numberPad
        ed.delegate = self
        ed.error = "Data de nascimento deve ser dd/MM/yyyy"
        ed.failure = {
            let invalidCount = ed.text.count != 10
            
            let date = ed.text.toDate()
            
            let invalidDate = date == nil
            
            return invalidDate || invalidCount
        }
        return ed
    }()
    
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.enable(false)
        btn.titleColor = .white
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(sendDidTap))
        return btn
    }()
    
    var viewModel: SignUpViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        container.addSubview(name)
        container.addSubview(email)
        container.addSubview(password)
        container.addSubview(document)
        container.addSubview(birthday)
        container.addSubview(send)
        
        scroll.addSubview(container)
        view.addSubview(scroll)
        
        let scrollContraints = [
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        let heightConstraint = container.heightAnchor.constraint(equalTo: view.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        let containerCosntraints = [
            container.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 490)
        ]
        
        let nameConstraints = [
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            email.topAnchor.constraint(equalTo: container.topAnchor, constant: 70.0),
        ]
        
        let emailConstraints = [
            email.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10.0),
        ]
        
        let passwordConstraints = [
            password.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10.0),
        ]
        
        let documentConstraints = [
            document.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            document.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            document.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
        ]
        
        let birthdayConstraints = [
            birthday.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            birthday.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            birthday.topAnchor.constraint(equalTo: document.bottomAnchor, constant: 10.0),
        ]
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            send.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(documentConstraints)
        NSLayoutConstraint.activate(birthdayConstraints)
        NSLayoutConstraint.activate(sendConstraints)
        
        NSLayoutConstraint.activate(scrollContraints)
        NSLayoutConstraint.activate(containerCosntraints)
        
        configureKeyboard(handle: keyboardHandle)
        configureDismissKeyboard()
    }
    
    lazy var keyboardHandle = KeyboardHandle { visible, height in
        if (!visible) {
            self.scroll.contentInset = .zero
            self.scroll.scrollIndicatorInsets = .zero
        } else {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: height, right: 0.0)
            self.scroll.contentInset = contentInsets
            self.scroll.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func sendDidTap(_ sender: UIButton) {
        viewModel?.send()
    }
    
}

extension SignUpViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
            return false
        }
        
        let nextTag = textField.tag + 1
        let component = container.findViewByTag(tag: nextTag) as? TextField
        
        if (component != nil) {
            component?.gainFocus()
        } else {
            view.endEditing(true)
        }
        
        return false
    }
    
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid {
            self.bitmaskResult = self.bitmaskResult | bitmask
        } else {
            self.bitmaskResult = self.bitmaskResult & ~bitmask
        }
        
        self.send.enable(
            (SignUpForm.name.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.email.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.password.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.document.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.birthday.rawValue & self.bitmaskResult != 0)
        )
        
        if bitmask == SignUpForm.name.rawValue {
            viewModel?.name = text
        }
        else if bitmask == SignUpForm.email.rawValue {
            viewModel?.email = text
        }
        else if bitmask == SignUpForm.password.rawValue {
            viewModel?.password = text
        }
        else if bitmask == SignUpForm.document.rawValue {
            viewModel?.document = text
        }
        else if bitmask == SignUpForm.birthday.rawValue {
            viewModel?.birthday = text
        }
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func viewModelDidChanged(state: SignUpState) {
        switch(state) {
            case .none:
                break
            case .loading:
                send.startLoading(true)
                break
            case .goToLogin:
                send.startLoading(false)
                alert(message: "Usuario cadastrado com sucesso!") {
                    self.viewModel?.goToLogin()
                }
                
                break
            case .error(let msg):
                send.startLoading(false)
                alert(message: msg)
                break
        }
    }
}
