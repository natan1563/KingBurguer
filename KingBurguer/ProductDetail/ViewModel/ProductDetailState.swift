//
//  ProductDetailState.swift
//  KingBurguer
//
//  Created by Natã Romão on 06/06/23.
//

import Foundation

enum ProductDetailState {
    case loading
    case success(ProductResponse)
    case successCoupon(CouponResponse)
    case error(String)
}
