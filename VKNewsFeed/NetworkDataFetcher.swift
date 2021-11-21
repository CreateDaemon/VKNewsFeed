//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 6.11.21.
//

import Foundation
import UIKit

protocol DataFetcher {
    func getFeed(nextFrom: String?,response: @escaping (FeedResponse?) -> Void)
    func getAvatarUser(response: @escaping (CurrentUserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(nextFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        var params = ["filters": "post, photo"]
        params["start_from"] = nextFrom
        networking.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
                return
            }
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    func getAvatarUser(response: @escaping (CurrentUserResponse?) -> Void) {
        let params = ["fields": "photo_50"]
        networking.request(path: API.avatarUser, params: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
                return
            }
            
            let decoded = decodeJSON(type: CurrentUserResponse.self, from: data)
            response(decoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from,
              let respons = try? decode.decode(type.self, from: data) else { return nil }
        return respons
    }
}
