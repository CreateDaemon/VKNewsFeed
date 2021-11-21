//
//  FooterTableView.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 21.11.21.
//

import UIKit

class FooterTableView: UIView {
    
    private let label: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.2273307443, green: 0.2323131561, blue: 0.2370453477, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() {
        addSubview(label)
        addSubview(loader)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8)
        ])
    }
    
    func startLoad() {
        loader.startAnimating()
    }
    
    func endLoad(_ titelLabel: String?) {
        loader.stopAnimating()
        label.text = titelLabel
    }
    
}
