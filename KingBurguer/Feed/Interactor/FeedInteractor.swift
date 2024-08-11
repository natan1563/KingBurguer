//
//  FeedInteractor.swift
//  KingBurguer
//
//  Created by Natã Romão on 19/05/23.
//

import Foundation


class FeedInteractor {
    
    private let remote: FeedRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetch(completion: @escaping (FeedResponse?, String?) -> Void) {
        return remote.fetch(completion: completion)
    }
    
    func fetchHighlight(completion: @escaping (HighlightResponse?, String?) -> Void) {
        return remote.fetchHighlight(completion: completion)
    }
    
    func logout() {
        local.deleteUserAuth()
    }
}
