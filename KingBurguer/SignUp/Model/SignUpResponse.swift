//
//  SignUpResponse.swift
//  KingBurguer
//
//  Created by Natã Romão on 12/04/23.
//

import Foundation

struct SignUpResponse: Decodable {
    
    let id: Int
    let name: String
    let email: String
    let document: String
    let birthday: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case document
        case birthday
    }
    
}
