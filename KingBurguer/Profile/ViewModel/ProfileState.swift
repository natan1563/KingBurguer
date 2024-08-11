//
//  ProfileState.swift
//  KingBurguer
//
//  Created by Natã Romão on 06/06/23.
//

import Foundation

enum ProfileState: Equatable {
    static func == (lhs: ProfileState, rhs: ProfileState) -> Bool {
        switch(lhs, rhs) {
            case (.loading, .loading):
                return true
            default:
                return false
        }
    }
    
    case loading
    case success(UserResponse)
    case error(String)
}
