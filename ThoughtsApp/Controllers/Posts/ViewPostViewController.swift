//
//  ViewPostViewController.swift
//  ThoughtsApp
//
//  Created by Paulo Filho on 23/08/22.
//

import UIKit

class ViewPostViewController: UITabBarController, UITableViewDataSource, UITableViewDelegate {
    
    private let post: BlogPost
    private let isOwnedByCurrentUser: Bool
    
    init(post: BlogPost, isOwnedByCurrentUser: Bool = false) {
        self.post = post
        self.isOwnedByCurrentUser = isOwnedByCurrentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(PostHeaderTableViewCell.self, forCellReuseIdentifier: PostHeaderTableViewCell.identifier)
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        if !isOwnedByCurrentUser {
            IAPManager.shared.logPostViewed()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // Table
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        // 0: title, 1: image, 2: text
        switch index {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none // Not selectable
            cell.textLabel?.numberOfLines = 0 // Allows line-wrapping
            cell.textLabel?.font = .systemFont(ofSize: 25, weight: .bold)
            cell.textLabel?.text = post.title
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostHeaderTableViewCell.identifier,
                for: indexPath) as? PostHeaderTableViewCell else {
                fatalError()
            }
            cell.selectionStyle = .none
            cell.configure(with: .init(imageUrl: post.headerImageUrl))
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = post.text
            return cell
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        // 0: title, 1: image, 2: text
        switch index {
        case 0:
            return UITableView.automaticDimension // Stretch with available space
        case 1:
            return 150
        case 2:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
}
