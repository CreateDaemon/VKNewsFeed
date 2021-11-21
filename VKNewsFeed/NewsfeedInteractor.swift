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
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
      
      switch request {
      case .getNewsFeed:
          service?.getNewsFeed(completion: { [weak self] feedResponse, relealPostIds in
              self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, postIds: relealPostIds))
          })
      case .revealPostId(postId: let postId):
          service?.revealPostId(forPostId: postId, completion: { [weak self] feedResponse, relealPostIds in
              self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, postIds: relealPostIds))
          })
      case .getUserData:
          service?.getUserData(completion: { [weak self] userData in
              self?.presenter?.presentData(response: .presentUserData(data: userData))
          })
      case .getNewBatch:
          presenter?.presentData(response: .presentLoaderView)
          service?.getNewBatch(completion: { [weak self] feedResponse, relealPostIds in
              self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, postIds: relealPostIds))
          })
      }
  }
    
}
