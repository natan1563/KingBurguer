//
//  FeedCoordinator.swift
//  KingBurguer
//
//  Created by Natã Romão on 29/05/23.
//

import Foundation
import UIKit

class FeedCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let interactor = FeedInteractor()
        
        let viewModel = FeedViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let signUpVC = FeedViewController()
        signUpVC.viewModel = viewModel
        
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func goToProductDetail(id: Int) {
        let coordinator = ProductDetailCoordinator(navigationController, id: id)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func goToLogin() {
        parentCoordinator?.goToLogin()
    }
    
}
