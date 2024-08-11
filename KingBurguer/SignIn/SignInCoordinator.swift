//
//  SignInCoordinator.swift
//  KingBurguer
//
//  Created by Natã Romão on 22/11/22.
//

import Foundation
import UIKit

class SignInCoordinator {
    
    private let window: UIWindow?
    private let navigationController: UINavigationController
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let interactor = SignInInteractor()
        
        let viewModel = SignInViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let signInVC = SignInViewController()
        signInVC.viewModel = viewModel
        
        navigationController.pushViewController(signInVC, animated: true)
        
        window?.rootViewController = navigationController
    }
    
    func signUp() {
        let signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
        signUpCoordinator.parentCoordinator = self
        signUpCoordinator.start()
    }
    
    func home() {
        let homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator.start()
    }
    
}
