//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 9.11.21.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentURLImage: String?
    
    func setImage(for url: String) {
        
        currentURLImage = url
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        
        // Перед тем как сделать запрос на сервис, проверяем, есть ли изображения в кэше
        if let cached = URLCache.shared.cachedResponse(for: request) {
            image = UIImage(data: cached.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if response?.url?.absoluteString == self?.currentURLImage {
                    guard let cached = URLCache.shared.cachedResponse(for: request) else { return }
                    self?.image = UIImage(data: cached.data)
                }
            }
        }
        dataTask.resume()
    }
}
