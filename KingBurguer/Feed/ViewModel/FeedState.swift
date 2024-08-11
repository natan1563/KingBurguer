//
//  FeedState.swift
//  KingBurguer
//
//  Created by Natã Romão on 19/05/23.
//

import Foundation

enum FeedState {
    case loading
    case success(FeedResponse)
    case successHighlight(HighlightResponse)
    case error(String)
}
