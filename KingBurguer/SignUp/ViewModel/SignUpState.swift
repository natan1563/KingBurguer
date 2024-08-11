//
//  SignUpState.swift
//  KingBurguer
//
//  Created by Natã Romão on 22/11/22.
//

import Foundation

enum SignUpState {
    case none
    case loading
    case goToLogin
    case error(String)
}
