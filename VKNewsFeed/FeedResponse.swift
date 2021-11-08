//
//  FeedResponse.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 6.11.21.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountadleItem?
    let likes: CountadleItem?
    let reposts: CountadleItem?
    let views: CountadleItem?
}

struct CountadleItem: Decodable {
    let count: Int
}
