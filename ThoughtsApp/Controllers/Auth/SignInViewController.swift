//
//  SigninViewController.swift
//  ThoughtsApp
//
//  Created by Paulo Filho on 23/08/22.
//

import UIKit

class SignInViewController: UITabBarController {
    
    // Header View
    private let headerView = SignInHeaderView()
    
    // Email field
    
    // Password field
    
    // Sign In button
    
    // Create Account button

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height/5)
    }

}
