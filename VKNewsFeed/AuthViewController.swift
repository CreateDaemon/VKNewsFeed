//
//  ViewController.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 5.11.21.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        authService = SceneDelegate.shared().authService
        view.backgroundColor = .red
    }

    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}

