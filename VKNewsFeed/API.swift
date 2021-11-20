//
//  API.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 6.11.21.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.131"
    
    static let newsFeed = "/method/newsfeed.get"
    static let avatarUser = "/method/users.get"
}
