//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 9.11.21.
//

import UIKit

class WebImageView: UIImageView {
    
    var currentUrlImage: String?
    
    func setImage(for url: String?) {
        
        currentUrlImage = url
        
        guard let url = url,
              let url = URL(string: url) else { self.image = nil; return }
        let request = URLRequest(url: url)
        
        // Перед тем как сделать запрос на сервис, проверяем, есть ли изображения в кэше
        if let cached = URLCache.shared.cachedResponse(for: request) {
            image = UIImage(data: cached.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard self?.currentUrlImage == response?.url?.absoluteString else { return }
            DispatchQueue.main.async {
                guard let cached = URLCache.shared.cachedResponse(for: request) else { return }
                self?.image = UIImage(data: cached.data)
            }
        }
        dataTask.resume()
    }
}
