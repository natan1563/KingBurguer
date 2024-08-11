//
//  SignInViewModel.swift
//  KingBurguer
//
//  Created by Natã Romão on 18/11/22.
//

import Foundation

protocol SignInViewModelDelegate {
    func viewModelDidChanged(state: SignInState)
}

class SignInViewModel {
    
    var email = ""
    var password = ""
    
    var delegate: SignInViewModelDelegate?
    var coordinator: SignInCoordinator?
    
    var state: SignInState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    private let interactor: SignInInteractor
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
    }
    
    func send() {
        state = .loading
        
        interactor.login(request: SignInRequest(username: email,
                                                password: password)) { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else {
                    self.state = .goToHome
                }
            }
        }
    }
    
    func goToSignUp() {
        coordinator?.signUp()
    }
   
    func goToHome() {
        coordinator?.home()
    }
    
}
