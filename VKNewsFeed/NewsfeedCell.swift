//
//  NewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 8.11.21.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String { get }
    var likes: String { get }
    var comments: String { get }
    var shares: String { get }
    var views: String { get }
    var photoAttecments: [FeedCellPhotoAttachmentViewModel] { get }
    var layoutCell: FrameElements { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

protocol FrameElements {
    var framePostLabel: CGRect { get }
    var frameMoreTextButton: CGRect { get }
    var framePostImage: CGRect { get }
    var frameGalleryView: CGRect { get }
    var frameFooter: CGRect { get }
    var totalHeightCell: CGFloat { get }
}

class NewsfeedCell: UITableViewCell {

    static let reuseId = "NewsfeedCell"
    
    @IBOutlet var iconImageView: WebImageView!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var postLabel: UILabel!
    @IBOutlet var cardView: UIView!
    @IBOutlet var header: UIView!
    @IBOutlet var postImage: WebImageView!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var footer: UIView!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var sharesLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!
    
    override func prepareForReuse() {
        iconImageView.setImage(for: nil)
        postImage.setImage(for: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        backgroundColor = .clear
        selectionStyle = .none
        iconImageView.layer.cornerRadius = iconImageView.bounds.height / 2
        iconImageView.clipsToBounds = true
//        imagePost.contentMode = .scaleAspectFill
    }

    func set(viewModel: FeedCellViewModel) {
        iconImageView.setImage(for: viewModel.iconUrlString)
//        postImage.setImage(for: viewModel.photoAttecment?.photoUrlString)
        nameLable.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        // Set frame
        postLabel.frame = viewModel.layoutCell.framePostLabel
        postImage.frame = viewModel.layoutCell.framePostImage
        footer.frame = viewModel.layoutCell.frameFooter
    }

}
