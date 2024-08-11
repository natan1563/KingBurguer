//
//  HighlightResponse.swift
//  KingBurguer
//
//  Created by Natã Romão on 26/05/23.
//

import Foundation

struct HighlightResponse: Decodable {
    
    let id: Int
    let productId: Int
    let pictureUrl: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case pictureUrl = "picture_url"
        case createdDate = "created_date"
    }
    
}
