//
//  ProductDetailInteractor.swift
//  KingBurguer
//
//  Created by Natã Romão on 06/06/23.
//

import Foundation

class ProductDetailInteractor {
    
    private let remote: ProductDetailRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetch(id: Int, completion: @escaping (ProductResponse?, String?) -> Void) {
        return remote.fetch(id: id, completion: completion)
    }
    
    func createCoupon(id: Int, completion: @escaping (CouponResponse?, String?) -> Void) {
        return remote.createCoupon(id: id, completion: completion)
    }
    
}
