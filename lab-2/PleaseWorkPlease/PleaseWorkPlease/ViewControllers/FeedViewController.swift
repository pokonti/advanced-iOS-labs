//
//  FeedViewController.swift
//  PleaseWorkPlease
//
//  Created by Aknur Seidazym on 24.02.2025.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let feedSystem = FeedSystem()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSamplePosts()
    }

    private func setupUI() {
        title = "Feed"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadSamplePosts() {
        let user1 = UserProfile(id: "1", username: "charlie", bio: "Tech enthusiast", profileImageURL: URL(string: "https://i.imgflip.com/2hxdqn.jpg"))
        let user2 = UserProfile(id: "2", username: "diana", bio: "Traveler & foodie", profileImageURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFT2G3H8S7rCEGhpUXzBvI8KXexxcMgCzOaQ&s"))
        let user3 = UserProfile(id: "3", username: "evan", bio: "Gamer & streamer", profileImageURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTmOu9rG6LWOkVce3SWM0_zOpYkIkUVyQbTw&s"))
        
        let post1 = Post(id: UUID(), author: user1, hashtags: ["coding", "swift"], content: "Just finished a cool Swift project! #coding #swift")
        let post2 = Post(id: UUID(), author: user2, hashtags: ["travel", "adventure"], content: "Exploring new places is the best! ✈️ #travel #adventure")
        let post3 = Post(id: UUID(), author: user3, hashtags: ["gaming", "fun"], content: "Streaming my favorite game tonight! 🎮 #gaming #fun")
        
        feedSystem.addPost(post1)
        feedSystem.addPost(post2)
        feedSystem.addPost(post3)
        
        tableView.reloadData()
    }

       // MARK: - UITableViewDataSource
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return feedSystem.getPosts().count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
           let post = feedSystem.getPosts()[indexPath.row]
           cell.textLabel?.numberOfLines = 0
           cell.textLabel?.text = "@\(post.author.username): \(post.content)"
           return cell
       }

       // MARK: - UITableViewDelegate
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           
           
           let post = feedSystem.getPosts()[indexPath.row]
           let profileVC = UserProfileViewController()
           profileVC.userProfile = post.author
           profileVC.isViewingOwnProfile = false
           navigationController?.pushViewController(profileVC, animated: true)
           
       }
    
        @objc private func viewMyProfile() {
            let profileVC = UserProfileViewController()
            profileVC.isViewingOwnProfile = true
            navigationController?.pushViewController(profileVC, animated: true)
        }
   }
