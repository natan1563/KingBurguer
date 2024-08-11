//
//  SignInInteractor.swift
//  KingBurguer
//
//  Created by Natã Romão on 08/05/23.
//

import Foundation


class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void) {
        remote.login(request: request) { response, error in
            
            if let r = response {
                let userAuth = UserAuth(accessToken: r.accessToken,
                                        refreshToken: r.refreshToken,
                                        expiresSeconds: Int(Date().timeIntervalSince1970 + Double(r.expiresSeconds)),
                                        tokenType: r.tokenType)
                
                self.local.insertUserAuth(userAuth: userAuth)
            }
            
            completion(response, error)
        }
    }
    
}
