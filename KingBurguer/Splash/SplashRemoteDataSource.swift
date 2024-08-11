//
//  SplashRemoteDataSource.swift
//  KingBurguer
//
//  Created by Natã Romão on 06/06/23.
//

import Foundation

class SplashRemoteDataSource {
    
    static let shared = SplashRemoteDataSource()
    
    func login(request: SplashRequest, completion: @escaping (SignInResponse?, Bool) -> Void) {
        WebServiceAPI.shared.call(path: .refreshToken, body: request, method: .put) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { return }
                    let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                    completion(response, false)
                    break
                    
                case .failure(_, _):
                    completion(nil, true)
                    break
            }
        }
    }
    
}
