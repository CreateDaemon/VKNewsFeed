//
//  NewsfeedCodeCell.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 11.11.21.
//

import Foundation
import UIKit

protocol NewsfeedCellCodeDelegate: NSObject {
    func revealPost(for cell: NewsfeedCodeCell)
}

final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = "cellCode"
    
    weak var delegate: NewsfeedCellCodeDelegate?
    
    //  MARK: - Elements View
    // First Layer
    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Second Layer
    private let header: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let postLabel: UITextView = {
        let view = UITextView()
        view.font = ConstantsSize.postLableFont
        view.textColor = #colorLiteral(red: 0.2274509804, green: 0.231372549, blue: 0.2352941176, alpha: 1)
        view.isScrollEnabled = false
        view.isSelectable = true
        view.isUserInteractionEnabled = true
        view.isEditable = false
        
        let padding = view.textContainer.lineFragmentPadding
        view.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        view.dataDetectorTypes = .all
        return view
    }()
    
    private let postImage: WebImageView = {
        let view = WebImageView()
        return view
    }()
    
    private let galleryView = GalleryCollectionView()
    
    private let footer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        let color = #colorLiteral(red: 0.4, green: 0.6235294118, blue: 0.831372549, alpha: 1)
        button.setTitleColor(color , for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        button.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
        return button
    }()
    
    // Thrid Layer
    private let iconImageView: WebImageView = {
        let view = WebImageView()
        view.layer.cornerRadius = ConstantsSize.heightHeader / 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = #colorLiteral(red: 0.2273307443, green: 0.2323131561, blue: 0.2370453477, alpha: 1)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Fourth Layer
    private let likesImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "like")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let likesLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = #colorLiteral(red: 0.6014422178, green: 0.6364172697, blue: 0.6786863208, alpha: 1)
        view.lineBreakMode = .byClipping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let commentsImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "comment")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let commentsLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = #colorLiteral(red: 0.6014422178, green: 0.6364172697, blue: 0.6786863208, alpha: 1)
        view.lineBreakMode = .byClipping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sharesImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "share")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sharesLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = #colorLiteral(red: 0.6014422178, green: 0.6364172697, blue: 0.6786863208, alpha: 1)
        view.lineBreakMode = .byClipping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewsImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eye")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewsLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = #colorLiteral(red: 0.6014422178, green: 0.6364172697, blue: 0.6786863208, alpha: 1)
        view.lineBreakMode = .byClipping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //  MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Objc metod
    @objc func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
    }
    
    //  MARK: - Override method
    override func prepareForReuse() {
        iconImageView.setImage(for: nil)
        postImage.setImage(for: nil)
    }
    
    //  MARK: - Overlay Constraints
    private func overlayFirstLayer() {
        addSubview(cardView)
        
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ConstantsSize.insetsCardView.left).isActive = true
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: ConstantsSize.insetsCardView.top).isActive = true
        cardView.rightAnchor.constraint(equalTo: rightAnchor, constant: -ConstantsSize.insetsCardView.right).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ConstantsSize.insetsCardView.bottom).isActive = true
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(header)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImage)
        cardView.addSubview(galleryView)
        cardView.addSubview(footer)
        
        // Set constraints for header
        header.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: ConstantsSize.insetsHeader.left).isActive = true
        header.topAnchor.constraint(equalTo: cardView.topAnchor, constant: ConstantsSize.insetsHeader.top).isActive = true
        header.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -ConstantsSize.insetsHeader.right).isActive = true
        header.heightAnchor.constraint(equalToConstant: ConstantsSize.heightHeader).isActive = true
        
        // Set constraints automatic for postLabel, moreTextButton, postImage(galleryView) and footer
        
    }
    
    private func overlayThridLayerOnHeader() {
        header.addSubview(iconImageView)
        let steckLabel: UIStackView = {
            let steck = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
            steck.axis = .vertical
            steck.distribution = .fillEqually
            steck.translatesAutoresizingMaskIntoConstraints = false
            steck.spacing = 5
            return steck
        }()
        header.addSubview(steckLabel)
        
        
        // Set constraints for iconImageView
        iconImageView.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: ConstantsSize.heightHeader).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: ConstantsSize.heightHeader).isActive = true
        
        // Set constraints for nameLabel and dateLabel
        steckLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5).isActive = true
        steckLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        steckLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -5).isActive = true
    }
    
    private func overlayThridLayerOnFooter() {
        likesView.widthAnchor.constraint(equalToConstant: ConstantsSize.footerViewViewsSize.width).isActive = true
        commentsView.widthAnchor.constraint(equalToConstant: ConstantsSize.footerViewViewsSize.width).isActive = true
        sharesView.widthAnchor.constraint(equalToConstant: ConstantsSize.footerViewViewsSize.width).isActive = true
        viewsView.widthAnchor.constraint(equalToConstant: ConstantsSize.footerViewViewsSize.width).isActive = true
        likesView.heightAnchor.constraint(equalToConstant: ConstantsSize.footerViewViewsSize.height).isActive = true
        commentsView.heightAnchor.constraint(equalToConstant: ConstantsSize.footerViewViewsSize.height).isActive = true
        sharesView.heightAnchor.constraint(equalToConstant: ConstantsSize.footerViewViewsSize.height).isActive = true
        viewsView.heightAnchor.constraint(equalToConstant: ConstantsSize.footerViewViewsSize.height).isActive = true
        let steckView: UIStackView = {
            let steck = UIStackView(arrangedSubviews: [likesView, commentsView, sharesView])
            steck.distribution = .fillEqually
            steck.translatesAutoresizingMaskIntoConstraints = false
            return steck
        }()
        
        footer.addSubview(steckView)
        footer.addSubview(viewsView)
        
        // Set constraints for likesView, commentsView, sharesView and viewsView
        steckView.leadingAnchor.constraint(equalTo: footer.leadingAnchor).isActive = true
        steckView.centerYAnchor.constraint(equalTo: footer.centerYAnchor).isActive = true
        viewsView.trailingAnchor.constraint(equalTo: footer.trailingAnchor).isActive = true
        viewsView.bottomAnchor.constraint(equalTo: footer.bottomAnchor).isActive = true
    }
    
    private func overlayFourthLayerOnFooterViews() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        helpInFourthLayer(view: likesView, viewImage: likesImage, viewLable: likesLabel)
        helpInFourthLayer(view: commentsView, viewImage: commentsImage, viewLable: commentsLabel)
        helpInFourthLayer(view: sharesView, viewImage: sharesImage, viewLable: sharesLabel)
        helpInFourthLayer(view: viewsView, viewImage: viewsImage, viewLable: viewsLabel)
    }
    
    private func helpInFourthLayer(view: UIView, viewImage: UIImageView, viewLable: UILabel) {
        viewImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        viewImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        viewImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        viewImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        viewLable.leadingAnchor.constraint(equalTo: viewImage.trailingAnchor, constant: 2).isActive = true
        viewLable.centerYAnchor.constraint(equalTo: viewImage.centerYAnchor).isActive = true
    }
    
    // MARK: - Set data for cell
    func set(viewModel: FeedCellViewModel) {
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThridLayerOnHeader()
        overlayThridLayerOnFooter()
        overlayFourthLayerOnFooterViews()
        
        iconImageView.setImage(for: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        if viewModel.photoAttecments.count == 1 {
            postImage.setImage(for: viewModel.photoAttecments[0].photoUrlString)
        } else if viewModel.photoAttecments.count > 1 {
            let photos = viewModel.photoAttecments
            galleryView.set(photos: photos)
        }
        
        // Set frame
        postLabel.frame = viewModel.layoutCell.framePostLabel
        postImage.frame = viewModel.layoutCell.framePostImage
        galleryView.frame = viewModel.layoutCell.frameGalleryView
        footer.frame = viewModel.layoutCell.frameFooter
        moreTextButton.frame = viewModel.layoutCell.frameMoreTextButton

    }
}
