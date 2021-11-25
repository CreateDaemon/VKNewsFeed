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
    var profiles: [Profile]
    var groups: [Group]
    let nextFrom: String
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
    let attachments: [Attachment]?
    let copyHistory: [CopyHistory]?
}

struct CopyHistory: Decodable {
    
}

struct Attachment: Decodable {
    let type: String
    let photo: Photo?
}

protocol FeedSizesPhoto {
    var url: String { get }
    var height: Int { get }
    var width: Int { get }
}

struct Photo: Decodable, FeedSizesPhoto {
    let sizes: [SizePhoto]
    
    var url: String {
        getSize().url
    }
    var height: Int {
        getSize().height
    }
    var width: Int {
        getSize().width
    }
    
    private func getSize() -> SizePhoto {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallGetSize = sizes.last(where: { $0.type == "z" }) {
            return fallGetSize
        } else {
            return SizePhoto(type: "wrong type",
                                url: "wrong url",
                                height: 0,
                                width: 0)
        }
    }
}

struct SizePhoto: Decodable {
    let type: String
    let url: String
    let height: Int
    let width: Int
}

struct CountadleItem: Decodable {
    let count: Int
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Decodable, ProfileRepresentable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String {
        firstName + lastName
    }
    var photo: String {
        photo100
    }
}

struct Group: Decodable, ProfileRepresentable {
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String {
        photo100
    }
}



