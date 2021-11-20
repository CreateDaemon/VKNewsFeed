//
//  CurrentUserResponse.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 20.11.21.
//

import Foundation

struct CurrentUserResponse: Decodable {
    let response: [UserData]
}

struct UserData: Decodable {
    let photo50: String
}
