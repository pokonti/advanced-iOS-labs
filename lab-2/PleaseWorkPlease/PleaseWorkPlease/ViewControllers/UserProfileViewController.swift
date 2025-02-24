//
//  UserProfileViewController.swift
//  PleaseWorkPlease
//
//  Created by Aknur Seidazym on 20.02.2025.
//

import UIKit

class UserProfileViewController: UIViewController, ProfileUpdateDelegate, ImageLoaderDelegate  {
    
    // TODO: Consider reference type for these properties
    var profileManager: ProfileManager?
    var imageLoader: ImageLoader?
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let bioLabel = UILabel()
    
    var isViewingOwnProfile: Bool = false
    var userProfile: UserProfile? {
       didSet {
           // Update the UI whenever the profile is set
           updateProfile(with: userProfile!)
       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupProfileManager()
        loadUserProfile()
        
        if isViewingOwnProfile {
           print("No profile")
       } else if let profile = userProfile {
           updateProfile(with: profile)
       } else {
           return 
       }
        
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bioLabel.font = UIFont.systemFont(ofSize: 16)
        bioLabel.numberOfLines = 0
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [profileImageView, nameLabel, bioLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    
    func setupProfileManager() {
        // TODO: Implement setup
        profileManager = ProfileManager(delegate: self)
        
        // Use weak self in closure to prevent retain cycle
        profileManager?.onProfileUpdate = { [weak self] profile in
            self?.updateProfile(with: profile)
        }
    }
    
    private func loadUserProfile() {
        // Only load the profile if it's not already set
        guard userProfile == nil else { return }

        profileManager?.loadProfile(id: "user_123") { [weak self] result in
            switch result {
            case .success(let profile):
                self?.userProfile = profile
            case .failure(let error):
                self?.profileLoadingError(error)
            }
        }
    }
    
    func updateProfile(with profile: UserProfile) {
         // TODO: Implement profile update
         // Consider: How to handle closure capture list?
         nameLabel.text = profile.username
         bioLabel.text = profile.bio
         
         if let url = profile.profileImageURL {
             imageLoader = ImageLoader()
             imageLoader?.delegate = self
             
             imageLoader?.completionHandler = { [weak self] image in
                 self?.profileImageView.image = image ?? UIImage(systemName: "person.crop.circle")
             }
             
             imageLoader?.loadImage(from: url)
         } else {
             profileImageView.image = UIImage(systemName: "person.crop.circle")
         }
     }
     
     
 }

extension UIViewController {
    func profileDidUpdate(_ profile: UserProfile) {
        print("Profile updated: \(profile.username)")
        
    }
    
    func profileLoadingError(_ error: any Error) {
        print("Failed to load profile: \(error.localizedDescription)")
        
    }
    
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage) {
        print("Image loaded via delegate")
        
    }
    
    func imageLoader(_ loader: ImageLoader, didFailWith error: any Error) {
        print("Image loading failed: \(error.localizedDescription)")
        
    }
    
    
}
