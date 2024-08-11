//
//  UserAuth.swift
//  KingBurguer
//
//  Created by Natã Romão on 08/05/23.
//

import Foundation

struct UserAuth: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresSeconds: Int
    let tokenType: String
}
