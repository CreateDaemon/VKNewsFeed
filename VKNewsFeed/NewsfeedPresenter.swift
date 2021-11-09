//
//  NewsfeedPresenter.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 8.11.21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
    
    private let dateFormater: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
      
      switch response {
      case .presentNewsFeed(feed: let feed):
          
          let cells = feed.items.map { cellViewModel(from: $0, profiles: feed.profiles, groups: feed.groups) }
          let feedViewModel = FeedViewModel.init(cells: cells)
          viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
      }
  }
  
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        
        let profile = profile(soerceId: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitel = dateFormater.string(from: date)
        
        return FeedViewModel.Cell.init(iconUrlString: profile.photo,
                                        name: profile.name,
                                        date: dateTitel,
                                        text: feedItem.text ?? "",
                                        likes: String(feedItem.likes?.count ?? 0),
                                        comments: String(feedItem.comments?.count ?? 0),
                                        shares: String(feedItem.reposts?.count ?? 0),
                                        views: String(feedItem.views?.count ?? 0))
    }
    
    private func profile(soerceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        let profilesOrGroups: [ProfileRepresentable] = soerceId >= 0 ? profiles : groups
        let normalSourceId = soerceId >= 0 ? soerceId : -soerceId
        let profile = profilesOrGroups.first { $0.id == normalSourceId
        }
        return profile!
    }
}
