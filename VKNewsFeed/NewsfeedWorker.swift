//
//  NewsfeedWorker.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 8.11.21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsfeedService {

    private let authService: AuthService
    private let networkService: Networking
    private let fetcher: DataFetcher
    
    private var revealedPostIds: [Int] = []
    private var response: FeedResponse?
    private var nextFrom: String?
    
    init() {
        authService = SceneDelegate.shared().authService
        networkService = NetworkService(authService: authService)
        fetcher = NetworkDataFetcher(networking: networkService)
    }
    
    func getNewsFeed(completion: @escaping (FeedResponse, [Int]) -> Void) {
        fetcher.getFeed(nextFrom: nil) { [weak self] feedResponse in
            self?.response = feedResponse
            self?.nextFrom = feedResponse?.nextFrom
            guard let response = self?.response else { return }
            completion(response, self!.revealedPostIds)
        }
    }
    
    func revealPostId(forPostId postId: Int ,completion: @escaping (FeedResponse, [Int]) -> Void) {
        revealedPostIds.append(postId)
        guard let response = self.response else { return }
        completion(response, self.revealedPostIds)
    }
    
    func getUserData(completion: @escaping (UserData) -> Void) {
        fetcher.getAvatarUser { data in
            guard let photo = data?.response.first else { return }
            completion(photo)
        }
    }
    
    func getNewBatch(completion: @escaping (FeedResponse, [Int]) -> Void) {
        fetcher.getFeed(nextFrom: nextFrom) { [weak self] feedResponse in
            guard let newResponse = feedResponse,
                  self?.nextFrom != newResponse.nextFrom else { return }
            self?.nextFrom = newResponse.nextFrom
            
            let response = self?.updateResponse(newResponse: newResponse)
            guard let response = response else { return }
            
            completion(response, self!.revealedPostIds)
        }
    }
    
    private func updateResponse(newResponse: FeedResponse) -> FeedResponse? {
        if response == nil {
            response = newResponse
        } else {
            response?.items.append(contentsOf: newResponse.items)
            
            var profiles = newResponse.profiles
            if let oldProfile = response?.profiles {
                let oldProfileFiltered = oldProfile.filter { oldProfile in
                    !profiles.contains { $0.id == oldProfile.id }
                }
                profiles.append(contentsOf: oldProfileFiltered)
            }
            response?.profiles = profiles
            
            var groups = newResponse.groups
            if let oldGroups = response?.groups {
                let oldGroupsFiltered = oldGroups.filter { oldGroups in
                    !groups.contains { $0.id == oldGroups.id }
                }
                groups.append(contentsOf: oldGroupsFiltered)
            }
            response?.groups = groups
        }
        
        guard let response = response else { return nil }
        return response
    }
}
