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
    private let layoutCalculator: NewsfeedCellLayoutCalculatorProtocol = NewsfeedCellLayoutCalculator()
    
    private let dateFormater: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
    return dt
    }()
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
      
      switch response {
      case .presentNewsFeed(feed: let feed, let postIds):
          
          let cells = feed.items.map { cellViewModel(from: $0, profiles: feed.profiles, groups: feed.groups, postIds: postIds) }
          let footerTitel = String.localizedStringWithFormat(NSLocalizedString("newsfeed cells count", comment: ""), cells.count)
          let feedViewModel = FeedViewModel.init(cells: cells, counterPosts: footerTitel)
          viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
      case .presentUserData(data: let data):
          let userViewModel = UserViewModel(photoUrlString: data.photo50)
          viewController?.displayData(viewModel: .displayAvatarUser(titelViewModel: userViewModel))
      case .presentLoaderView:
          viewController?.displayData(viewModel: .displayLoaderView)
      }
  }
  
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], postIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = profile(soerceId: feedItem.sourceId, profiles: profiles, groups: groups)
        let photoAttachmens = photoAttechments(feed: feedItem)
        
        let isFullSized = postIds.contains(feedItem.postId)
        
        let layout = layoutCalculator.cellLayoutCalculator(postLabelText: feedItem.text, photoAttachments: photoAttachmens, isFullSized: isFullSized)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitel = dateFormater.string(from: date)
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitel,
                                       text: feedItem.text ?? "",
                                       likes: contersFormater(counter: feedItem.reposts?.count),
                                       comments: contersFormater(counter: feedItem.reposts?.count),
                                       shares: contersFormater(counter: feedItem.reposts?.count),
                                       views: contersFormater(counter: feedItem.reposts?.count),
                                       photoAttecments: photoAttachmens,
                                       layoutCell: layout)
    }
    
    private func contersFormater(counter: Int?) -> String? {
        guard let counter = counter else { return nil }
        var counterString = String(counter)
        
        switch counterString.count {
        case 1...3:
            break
        case 4...6:
            counterString = String(counterString.dropLast(3)) + "K"
        case 4...6:
            counterString = String(counterString.dropLast(6)) + "M"
        default: return nil
        }
        
        return counterString
    }
    
    private func profile(soerceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        let profilesOrGroups: [ProfileRepresentable] = soerceId >= 0 ? profiles : groups
        let normalSourceId = soerceId >= 0 ? soerceId : -soerceId
        let profile = profilesOrGroups.first { $0.id == normalSourceId }
        return profile!
    }
    
    private func photoAttechments(feed: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachman] {
        guard let attachments = feed.attachments?.compactMap({ attachment in
            attachment.photo
        }) else { return [] }
        return attachments.map { photo in
            FeedViewModel.FeedCellPhotoAttachman.init(photoUrlString: photo.url,
                                                      width: photo.width,
                                                      height: photo.height)
        }
    }
}
