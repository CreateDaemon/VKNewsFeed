//
//  NewsfeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 10.11.21.
//

import UIKit

struct ConstantsSize {
    static let insetsCardView = UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
    static let widthCardView = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - (Self.insetsCardView.left + Self.insetsCardView.right)
    
    static let startPointHeader = CGPoint(x: 6, y: 6)
    static let heightHeader: CGFloat = 36
    
    static let insetsPostLabel = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
    
    static let insetsPostImage = UIEdgeInsets(top: insetsPostLabel.bottom, left: 0, bottom: 8, right: 0)
    
    static let heightFooter: CGFloat = 46
    static let insetsFooter = UIEdgeInsets(top: insetsPostImage.bottom, left: 0, bottom: 0, right: 0)
}

struct frameForCell: FrameElements {
    var frameHeader: CGRect
    var framePostLabel: CGRect
    var framePostImage: CGRect
    var frameFooter: CGRect
    var totalHeightCell: CGFloat
}

class NewsfeedCellLayoutCalculator {
    
    func cellLayoutCalculator(postLabelText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FrameElements {
        // MARK: - 1. Let's calculate frame Header
        let frameHeader = CGRect(origin: ConstantsSize.startPointHeader,
                                 size: CGSize(
                                    width: ConstantsSize.widthCardView - (ConstantsSize.startPointHeader.x + ConstantsSize.startPointHeader.y),
                                    height: ConstantsSize.heightHeader)
                                 )
        
        var lastY = frameHeader.origin.y + frameHeader.height
        
        // MARK: - 2. Let's calculate frame postLabel if he is
        var framePostLabel = CGRect(origin: .zero, size: .zero)
        if let text = postLabelText, !text.isEmpty {
            let widthPostLabel = ConstantsSize.widthCardView - (ConstantsSize.insetsPostLabel.left + ConstantsSize.insetsPostLabel.right)
            let heightPostLabel = text.height(width: widthPostLabel,
                        font: UIFont.systemFont(ofSize: 15))
            framePostLabel = CGRect(origin: CGPoint(x: ConstantsSize.insetsPostLabel.left,
                                                    y: lastY + ConstantsSize.insetsPostLabel.top),
                                    size: CGSize(width: widthPostLabel,
                                                 height: heightPostLabel))
            lastY += ConstantsSize.insetsPostLabel.top + framePostLabel.height
        }
        // MARK: - 3. Let's calculate frame postImage if he is
        var framePostImage = CGRect(origin: .zero, size: .zero)
        if let photoSize = photoAttachment {
            let scaleHeightPhoto = (ConstantsSize.widthCardView * CGFloat(photoSize.height)) / CGFloat(photoSize.width)
            framePostImage = CGRect(origin: CGPoint(x: ConstantsSize.insetsPostImage.left,
                                                    y: lastY + ConstantsSize.insetsPostImage.top),
                                    size: CGSize(width: ConstantsSize.widthCardView,
                                                 height: scaleHeightPhoto))
            lastY += ConstantsSize.insetsPostImage.top + framePostImage.height
        }
        // MARK: - 4. Let's calculate frame Footer
        let frameFooter = CGRect(origin: CGPoint(x: ConstantsSize.insetsFooter.left,
                                                 y: lastY + ConstantsSize.insetsFooter.top),
                                 size: CGSize(width: ConstantsSize.widthCardView,
                                              height: ConstantsSize.heightFooter))
        // MARK: - 5. Let's calculate size totalCell
        let totalHeightCell = lastY + ConstantsSize.insetsFooter.top + frameFooter.height + ConstantsSize.insetsCardView.bottom
        
        return frameForCell(frameHeader: frameHeader,
                            framePostLabel: framePostLabel,
                            framePostImage: framePostImage,
                            frameFooter: frameFooter,
                            totalHeightCell: totalHeightCell)
    }
}
