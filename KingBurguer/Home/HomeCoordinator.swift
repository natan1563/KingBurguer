//
//  HomeCoordinator.swift
//  KingBurguer
//
//  Created by Natã Romão on 22/11/22.
//

import Foundation
import UIKit

class HomeCoordinator {
    
    private let window: UIWindow?
    
    let navFeedVC = UINavigationController()
    let navProfileVC = UINavigationController()
    
    private var signInCoordinator: SignInCoordinator?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let homeVC = HomeViewController()
        
        let feedCordinator = FeedCoordinator(navFeedVC)
        feedCordinator.parentCoordinator = self
        feedCordinator.start()
        
        let profileCoordinator = ProfileCoordinator(navProfileVC)
        profileCoordinator.start()
        
        
        homeVC.setViewControllers([navFeedVC, navProfileVC], animated: true)
        
        window?.rootViewController = homeVC
    }
    
    func goToLogin() {
        signInCoordinator = SignInCoordinator(window: window)
        signInCoordinator?.start()
    }
    
}
