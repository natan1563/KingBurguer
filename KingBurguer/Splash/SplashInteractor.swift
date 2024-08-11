//
//  SplashInteractor.swift
//  KingBurguer
//
//  Created by Natã Romão on 06/06/23.
//

import Foundation


class SplashInteractor {
    
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func login(request: SplashRequest, completion: @escaping (SignInResponse?, Bool) -> Void) {
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
