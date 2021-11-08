//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 6.11.21.
//

import Foundation
import UIKit

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post, photo"]
        networking.request(path: API.newFeed, params: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
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
