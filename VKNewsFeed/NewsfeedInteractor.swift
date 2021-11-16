//
//  NewsfeedInteractor.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 8.11.21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {

  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    private var postIds: [Int] = []
    private var response: FeedResponse?
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
      
      switch request {
      case .getNewsFeed:
          fetcher.getFeed { [weak self] feedResponse in
              self?.response = feedResponse
              self?.callPresentData()
          }
      case .revealPostId(postId: let postId):
          postIds.append(postId)
          callPresentData()
      }
  }
  
    private func callPresentData() {
        guard let response = response else { return }
        presenter?.presentData(response: .presentNewsFeed(feed: response, postIds: postIds))
    }
}
