//
//  Constants.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 12.11.21.
//

import Foundation
import UIKit

struct ConstantsSize {
    static let insetsCardView = UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
    static let widthCardView = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - (Self.insetsCardView.left + Self.insetsCardView.right)
    
    static let insetsHeader = UIEdgeInsets(top: 6, left: 6, bottom: 8, right: 6)
    static let heightHeader: CGFloat = 60
    
    static let insetsPostLabel = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
    static let postLableFont = UIFont.systemFont(ofSize: 15)
    
    static let insetsPostImage = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    
    static let heightFooter: CGFloat = 50
    static let insetsFooter = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    static let footerViewViewsSize = CGSize(width: 80, height: Self.heightFooter)
    
    static let sizeMoreTextButton = CGSize(width: 170, height: 30)
    
    static let minifiedPostLimitLines: CGFloat = 8
    
    static let insetTopTableView: CGFloat = 10
}
