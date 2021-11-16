//
//  GalleryCollectionViewCell.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 14.11.21.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    private let image: WebImageView = {
        let view = WebImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.backgroundColor = #colorLiteral(red: 0.9117177725, green: 0.918438971, blue: 0.927837193, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        image.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(fromUrl: String?) {
        image.setImage(for: fromUrl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
    
    override func prepareForReuse() {
        image.setImage(for: nil)
    }
}
