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
}

class NewsfeedCell: UITableViewCell {

    static let reuseId = "NewsfeedCell"
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var postLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var sharesLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(viewModel: FeedCellViewModel) {
        nameLable.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
    }

}
