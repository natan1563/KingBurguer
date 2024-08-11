//
//  SignUpViewModel.swift
//  KingBurguer
//
//  Created by Natã Romão on 22/11/22.
//

import Foundation

protocol SignUpViewModelDelegate {
    func viewModelDidChanged(state: SignUpState)
}

class SignUpViewModel {
    
    var name = ""
    var email = ""
    var password = ""
    var document = ""
    var birthday = ""
    
    var delegate: SignUpViewModelDelegate?
    var coordinator: SignUpCoordinator?
    
    var state: SignUpState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    private let interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    func send() {
        state = .loading
        
        let birthdayFormatted = birthday.toDate()?.toString() ?? ""
        let documentFormatted = document.digits
    
        interactor.createUser(request: SignUpRequest(name: name,
                                                     email: email,
                                                     password: password,
                                                     document: documentFormatted,
                                                     birthday: birthdayFormatted)) { created, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let created = created {
                    if created {
                        self.state = .goToLogin
                    }
                }
            }
        }
    }
    
    func goToLogin() {
        coordinator?.login()
    }
    
}
