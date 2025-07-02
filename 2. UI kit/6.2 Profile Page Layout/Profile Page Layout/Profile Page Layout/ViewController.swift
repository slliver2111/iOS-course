//
//  ViewController.swift
//  Profile Page Layout
//
//  Created by Artur Bednarz on 29/06/2025.
//

import UIKit

class ViewController: UIViewController {
    private let userProfile = User.hardCodeExampleUser()
    
    let mainLayoutStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 24
        sv.alignment = .fill
        return sv
    }()
    
    let userInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        sv.alignment = .center
        return sv
    }()
    
    let nameAndButtonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .leading
        return sv
    }()
    
    let bioStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        sv.alignment = .center
        return sv
    }()
    
    let statisticsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        sv.alignment = .center
        sv.distribution = .fillEqually
        return sv
    }()
    
    let postsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .center
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainLayout()
        configureUserInfoSection()
        configureBioSection()
        configureStatisticsSection()
    }
    
    private func configureMainLayout() {
        view.addSubview(mainLayoutStackView)
        
        mainLayoutStackView.addArrangedSubview(userInfoStackView)
        mainLayoutStackView.addArrangedSubview(bioStackView)
        mainLayoutStackView.addArrangedSubview(statisticsStackView)
        mainLayoutStackView.addArrangedSubview(postsStackView)
        
        NSLayoutConstraint.activate([
            mainLayoutStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLayoutStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            mainLayoutStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainLayoutStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    
    private func configureUserInfoSection() {
        let photo = UIImageView(image: userProfile.photo)
        photo.contentMode = .scaleAspectFit
        photo.layer.cornerRadius = 40
        photo.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            photo.widthAnchor.constraint(equalToConstant: 80),
            photo.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        let name = UILabel()
        name.text = userProfile.name
        name.textColor = .white
        name.numberOfLines = 0
        name.font = .systemFont(ofSize: 24, weight: .bold)
        
        let followButton = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Follow"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        followButton.configuration = config

        
        userInfoStackView.addArrangedSubview(photo)
        userInfoStackView.addArrangedSubview(nameAndButtonStackView)
        nameAndButtonStackView.addArrangedSubview(name)
        nameAndButtonStackView.addArrangedSubview(followButton)
    }

    private func configureBioSection() {
        let bioDescr = UILabel()
        bioDescr.text = userProfile.bio
        bioDescr.numberOfLines = 0
        bioDescr.textColor = .white
        bioDescr.font = .systemFont(ofSize: 16)
        
        bioStackView.addArrangedSubview(bioDescr)
    }
    
    private func configureStatisticsSection() {
        let followersCountLabel = UILabel()
        followersCountLabel.text = String(userProfile.followerCount)
        followersCountLabel.textColor = .white
        followersCountLabel.font = .systemFont(ofSize: 16)
        
        let followersLabel = UILabel()
        followersLabel.text = "Followers"
        followersLabel.textColor = .white
        followersLabel.font = .systemFont(ofSize: 12)
        
        let sv1 = UIStackView(arrangedSubviews: [followersCountLabel, followersLabel])
        sv1.axis = .vertical
        sv1.spacing = 6
        sv1.alignment = .center
        
        let followingLabel = UILabel()
        followingLabel.text = String(userProfile.followingCount)
        followingLabel.textColor = .white
        followingLabel.font = .systemFont(ofSize: 16)
        
        let followingCountLabel = UILabel()
        followingCountLabel.text = "Following"
        followingCountLabel.textColor = .white
        followingCountLabel.font = .systemFont(ofSize: 12)
        
        let sv2 = UIStackView(arrangedSubviews: [followingLabel, followingCountLabel])
        sv2.axis = .vertical
        sv2.spacing = 6
        sv2.alignment = .center
        
        let postsLabel = UILabel()
        postsLabel.text = String(userProfile.postsCount)
        postsLabel.textColor = .white
        postsLabel.font = .systemFont(ofSize: 16)
        
        let postsCountLabel = UILabel()
        postsCountLabel.text = "Posts"
        postsCountLabel.textColor = .white
        postsCountLabel.font = .systemFont(ofSize: 12)
        
        let sv3 = UIStackView(arrangedSubviews: [postsLabel, postsCountLabel])
        sv3.axis = .vertical
        sv3.spacing = 6
        sv3.alignment = .center
        
        statisticsStackView.addArrangedSubview(sv1)
        statisticsStackView.addArrangedSubview(sv2)
        statisticsStackView.addArrangedSubview(sv3)
    }
}
