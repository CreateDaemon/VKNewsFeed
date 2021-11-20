//
//  SearchTextField.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 20.11.21.
//

import UIKit

class SearchTextField: UITextField {
    
    private let searchImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "search")
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9117177725, green: 0.918438971, blue: 0.927837193, alpha: 1)
        font = UIFont.systemFont(ofSize: 14)
        clearButtonMode = .whileEditing
        borderStyle = .none
        placeholder = "Search"
        
        leftView = searchImage
        leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
    
}
