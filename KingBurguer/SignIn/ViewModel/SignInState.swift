//
//  SignInState.swift
//  KingBurguer
//
//  Created by Natã Romão on 18/11/22.
//

import Foundation

enum SignInState {
    case none
    case loading
    case goToHome
    case error(String)
}
