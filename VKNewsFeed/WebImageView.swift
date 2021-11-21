//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 9.11.21.
//

import UIKit

class WebImageView: UIImageView {
    
    private let loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        loader.style = .large
        return loader
    }()
    
    var currentUrlImage: String?
    
    func setImage(for url: String?) {
        
        loader.startAnimating()
        
        currentUrlImage = url
        
        guard let url = url,
              let url = URL(string: url) else {
                  self.loader.stopAnimating()
                  self.image = nil
                  return }
        let request = URLRequest(url: url)
        
        // Перед тем как сделать запрос на сервис, проверяем, есть ли изображения в кэше
        if let cached = URLCache.shared.cachedResponse(for: request) {
            loader.stopAnimating()
            image = UIImage(data: cached.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard self?.currentUrlImage == response?.url?.absoluteString else { return }
            DispatchQueue.main.async {
                guard let cached = URLCache.shared.cachedResponse(for: request) else { return }
                self?.loader.stopAnimating()
                self?.image = UIImage(data: cached.data)
            }
        }
        dataTask.resume()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(loader)
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
