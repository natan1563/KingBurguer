//
//  ProfileCoordinator.swift
//  KingBurguer
//
//  Created by Natã Romão on 16/06/23.
//

import UIKit


class ProfileCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let interactor = ProfileInteractor()
        
        let viewModel = ProfileViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let vc = ProfileViewController(style: .plain)
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
