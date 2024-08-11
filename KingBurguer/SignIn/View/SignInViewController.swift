//
//  SignInViewController.swift
//  KingBurguer
//
//  Created by Natã Romão on 17/11/22.
//

import Foundation
import UIKit

enum SignInForm: Int {
    case email    = 0x1
    case password = 0x2
}

class SignInViewController: UIViewController {
    
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
    
    lazy var email: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu e-mail"
        ed.returnKeyType = .next
        ed.error = "E-mail invalido"
        ed.keyboardType = .emailAddress
        ed.bitmask = SignInForm.email.rawValue
        ed.failure = {
            return !ed.text.isEmail()
        }
        ed.delegate = self
        return ed
    }()
   
    lazy var password: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua senha"
        ed.returnKeyType = .done
        ed.error = "Senha deve ter no minimo 8 caracteres"
        ed.secureTextEntry = true
        ed.bitmask = SignInForm.password.rawValue
        ed.failure = {
            return ed.text.count < 8
        }
        ed.delegate = self
        return ed
    }()
    
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.backgroundColor = .red
        btn.enable(false)
        btn.addTarget(self, action: #selector(sendDidTap))
        return btn
    }()
    
    lazy var register: UIButton = {
        let btn = UIButton()
        btn.setTitle("Criar Conta", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(registerDidTap), for: .touchUpInside)
        return btn
    }()
    
    var viewModel: SignInViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: explicar o que e o super e o ciclo das viewControllers
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Login"
        
        container.addSubview(email)
        container.addSubview(password)
        container.addSubview(send)
        container.addSubview(register)
        
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

        let emailConstraints = [
            email.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            email.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            email.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -150.0),
        ]
        
        let passwordConstraints = [
            password.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10.0),
        ]
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            send.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let registerConstraints = [
            register.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            register.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            register.topAnchor.constraint(equalTo: send.bottomAnchor, constant: 15.0),
            register.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(sendConstraints)
        NSLayoutConstraint.activate(registerConstraints)
        
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
    
    @objc func registerDidTap(_ sender: UIButton) {
        viewModel?.goToSignUp()
    }

}

extension SignInViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
        } else {
            password.gainFocus()
        }
        return false
    }
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid {
            self.bitmaskResult = self.bitmaskResult | bitmask
        } else {
            self.bitmaskResult = self.bitmaskResult & ~bitmask
        }
        
        self.send.enable((SignInForm.email.rawValue & self.bitmaskResult != 0)
                         && (SignInForm.password.rawValue & self.bitmaskResult != 0))
        
        if bitmask == SignInForm.email.rawValue {
            viewModel?.email = text
        }
        else if bitmask == SignInForm.password.rawValue {
            viewModel?.password = text
        }
    }
}

extension SignInViewController: SignInViewModelDelegate {
    func viewModelDidChanged(state: SignInState) {
        switch(state) {
            case .none:
                break
            case .loading:
                send.startLoading(true)
                break
            case .goToHome:
                send.startLoading(false)
                viewModel?.goToHome()
                break
            case .error(let msg):
                self.send.startLoading(false)
                alert(message: msg)
                break
        }
    }
}
