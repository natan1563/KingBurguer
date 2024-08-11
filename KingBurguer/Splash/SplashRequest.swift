//
//  SplashRequest.swift
//  KingBurguer
//
//  Created by Natã Romão on 06/06/23.
//

import Foundation

struct SplashRequest: Encodable {
    
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
    
}
