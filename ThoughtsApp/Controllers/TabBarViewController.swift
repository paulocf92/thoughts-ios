//
//  TabBarViewController.swift
//  ThoughtsApp
//
//  Created by Paulo Filho on 23/08/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpControllers()
    }
    

    private func setUpControllers() {
        let home = HomeViewController()
        home.title = "Home"
        let profile = ProfileViewController()
        profile.title = "Profile"
        
        home.navigationItem.largeTitleDisplayMode = .always
        profile.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: profile)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2], animated: true)
    }
}
