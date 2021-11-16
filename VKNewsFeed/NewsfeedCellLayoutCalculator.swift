//
//  NewsfeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 10.11.21.
//

import UIKit

struct frameForCell: FrameElements {
    var framePostLabel: CGRect
    var frameMoreTextButton: CGRect
    var framePostImage: CGRect
    var frameGalleryView: CGRect
    var frameFooter: CGRect
    var totalHeightCell: CGFloat
}

protocol NewsfeedCellLayoutCalculatorProtocol: AnyObject {
    func cellLayoutCalculator(postLabelText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSized: Bool) -> FrameElements
}

final class NewsfeedCellLayoutCalculator: NewsfeedCellLayoutCalculatorProtocol {
    
    func cellLayoutCalculator(postLabelText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel],  isFullSized: Bool) -> FrameElements {
        
        var lastPointY = ConstantsSize.heightHeader + ConstantsSize.insetsHeader.top
        
        // MARK: - 1. Let's calculate frame postLabel if he is
        var framePostLabel = CGRect.zero
        var frameMoreTextLabel = CGRect.zero
        if let text = postLabelText, !text.isEmpty {
            let widthPostLabel = ConstantsSize.widthCardView - (ConstantsSize.insetsPostLabel.left + ConstantsSize.insetsPostLabel.right)
            var heightPostLabel = text.height(width: widthPostLabel,
                        font: UIFont.systemFont(ofSize: 15))
            // MARK: - 2. Let's calculate frame moreTextButton if he is
            let limitLinesText = ConstantsSize.minifiedPostLimitLines * ConstantsSize.postLableFont.lineHeight
            if !isFullSized, heightPostLabel > limitLinesText {
                heightPostLabel = limitLinesText
                framePostLabel = CGRect(origin: CGPoint(x: ConstantsSize.insetsPostLabel.left, y: lastPointY + ConstantsSize.insetsPostLabel.top),
                                        size: CGSize(width: widthPostLabel, height: heightPostLabel))
                frameMoreTextLabel = CGRect(origin: CGPoint(x: ConstantsSize.insetsPostLabel.left, y: framePostLabel.maxY),
                                            size: ConstantsSize.sizeMoreTextButton)
            } else {
                framePostLabel = CGRect(origin: CGPoint(x: ConstantsSize.insetsPostLabel.left, y: lastPointY + ConstantsSize.insetsPostLabel.top),
                                        size: CGSize(width: widthPostLabel, height: heightPostLabel))
            }
            lastPointY += ConstantsSize.insetsPostLabel.top + framePostLabel.height + frameMoreTextLabel.height
        }
        // MARK: - 3. Let's calculate frame postImage(galleryView) if he is
        var framePostImage = CGRect.zero
        var frameGalleryView = CGRect.zero
        
        if photoAttachments.count == 1, let photoSize = photoAttachments.first {
            let scaleHeightPhoto = (ConstantsSize.widthCardView * CGFloat(photoSize.height)) / CGFloat(photoSize.width)
            framePostImage = CGRect(origin: CGPoint(x: ConstantsSize.insetsPostImage.left,
                                                    y: lastPointY + ConstantsSize.insetsPostImage.top),
                                    size: CGSize(width: ConstantsSize.widthCardView,
                                                 height: scaleHeightPhoto))
            lastPointY += ConstantsSize.insetsPostImage.top + framePostImage.height
        } else if photoAttachments.count > 1 {
            
            var photos = [CGSize]()
            for photo in photoAttachments {
                let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                photos.append(photoSize)
            }
            
            let rowHeight = RowLayout.rowHeightCounter(superviewWidth: ConstantsSize.widthCardView, photosArray: photos)
            
            frameGalleryView = CGRect(origin: CGPoint(x: 0,
                                                    y: lastPointY + ConstantsSize.insetsPostImage.top),
                                    size: CGSize(width: ConstantsSize.widthCardView,
                                                 height: rowHeight!))
            lastPointY += ConstantsSize.insetsPostImage.top + frameGalleryView.height
        }
        
        // MARK: - 4. Let's calculate frame Footer
        let frameFooter = CGRect(origin: CGPoint(x: ConstantsSize.insetsFooter.left,
                                                 y: lastPointY + ConstantsSize.insetsFooter.top),
                                 size: CGSize(width: ConstantsSize.widthCardView,
                                              height: ConstantsSize.heightFooter))
        // MARK: - 5. Let's calculate size totalCell
        let totalHeightCell = frameFooter.maxY + ConstantsSize.insetsCardView.bottom
        
        return frameForCell(framePostLabel: framePostLabel,
                            frameMoreTextButton: frameMoreTextLabel,
                            framePostImage: framePostImage,
                            frameGalleryView: frameGalleryView,
                            frameFooter: frameFooter,
                            totalHeightCell: totalHeightCell)
    }
}
