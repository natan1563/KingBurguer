//
//  SignUpResponseError.swift
//  KingBurguer
//
//  Created by Natã Romão on 12/04/23.
//

import Foundation

struct ResponseError: Decodable {
    
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}
