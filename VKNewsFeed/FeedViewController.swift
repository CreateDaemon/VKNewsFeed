//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 6.11.21.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        networkService.getFeed()
    }
}
