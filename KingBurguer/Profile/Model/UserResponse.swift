//
//  UserResponse.swift
//  KingBurguer
//
//  Created by Natã Romão on 16/06/23.
//

import Foundation

struct UserResponse: Decodable {
    
    let id: Int
    let name: String
    let email: String
    let document: String
    let birthday: String
   
}
