//
//  SignUpInteractor.swift
//  KingBurguer
//
//  Created by Natã Romão on 04/05/23.
//

import Foundation

class SignUpInteractor {
    
    private let remote: SignUpRemoteDataSource = .shared
    
    func createUser(request: SignUpRequest, completion: @escaping (Bool?, String?) -> Void) {
        remote.createUser(request: request, completion: completion)
    }
    
}
