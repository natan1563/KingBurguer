//
//  SignInRequest.swift
//  KingBurguer
//
//  Created by Natã Romão on 02/05/23.
//

import Foundation


struct SignInRequest: Encodable {
    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
    
}
