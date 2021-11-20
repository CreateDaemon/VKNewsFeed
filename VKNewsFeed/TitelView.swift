//
//  TitelView.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 20.11.21.
//

import UIKit

protocol TitelViewModel {
    var photoUrlString: String? { get }
}

class TitelView: UIView {
    
    private let textField = SearchTextField()
    
    private let avatarUserImage: WebImageView = {
        let image = WebImageView()
        image.backgroundColor = #colorLiteral(red: 0.9467977881, green: 0.9467977881, blue: 0.9467977881, alpha: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override var intrinsicContentSize: CGSize {
        UIView.layoutFittingExpandedSize
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview() {
        addSubview(textField)
        addSubview(avatarUserImage)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            // Add constroints for textField
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            textField.trailingAnchor.constraint(equalTo: avatarUserImage.leadingAnchor, constant: -10),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            // Add constroints for avatarUserImage
            avatarUserImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarUserImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            avatarUserImage.heightAnchor.constraint(equalTo: textField.heightAnchor),
            avatarUserImage.widthAnchor.constraint(equalTo: textField.heightAnchor)
                                    ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarUserImage.layer.masksToBounds = true
        avatarUserImage.layer.cornerRadius = avatarUserImage.bounds.height / 2
    }
    
    func set(userViewModel: TitelViewModel) {
        avatarUserImage.setImage(for: userViewModel.photoUrlString)
    }
    
}
