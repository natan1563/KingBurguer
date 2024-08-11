//
//  ProductDetailCoordinator.swift
//  KingBurguer
//
//  Created by Natã Romão on 06/06/23.
//

import Foundation
import UIKit

class ProductDetailCoordinator {
    
    private let navigationController: UINavigationController
    private let id: Int
    
    var parentCoordinator: FeedCoordinator?
    
    init(_ navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let interactor = ProductDetailInteractor()
        
        let viewModel = ProductDetailViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let vc = ProductDetailViewController()
        vc.id = id
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
