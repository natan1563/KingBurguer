//
//  CouponResponse.swift
//  KingBurguer
//
//  Created by Natã Romão on 06/06/23.
//

import Foundation

struct CouponResponse: Decodable {
    
    let id: Int
    let productId: Int
    let userId: Int
    let coupon: String
    let expiresDate: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case userId = "user_id"
        case coupon
        case createdDate = "created_date"
        case expiresDate = "expires_date"
    }
    
}
