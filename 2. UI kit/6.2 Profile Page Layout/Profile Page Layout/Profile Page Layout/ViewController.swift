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
    
    var taggedPostsStackView: UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        
        NSLayoutConstraint.activate([
            mainLayoutStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLayoutStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainLayoutStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    
    private func configureUserInfoSection() {
        let photo = UIImageView(image: userProfile.photo)
        photo.contentMode = .scaleAspectFit
        photo.layer.cornerRadius = 40
        photo.clipsToBounds = true
        userInfoStackView.addArrangedSubview(photo)
        
        NSLayoutConstraint.activate([
            photo.widthAnchor.constraint(equalToConstant: 80),
            photo.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        let name = UILabel()
        name.text = userProfile.name
        name.textColor = .label
        name.numberOfLines = 0
        name.font = .systemFont(ofSize: 24, weight: .bold)
        
        let followButton = createButton(title: "Follow")
        followButton.addTarget(self, action: #selector(addTaggedSection), for: .touchUpInside)
        
        userInfoStackView.addArrangedSubview(nameAndButtonStackView)
        nameAndButtonStackView.addArrangedSubview(name)
        nameAndButtonStackView.addArrangedSubview(followButton)
    }
    
    private func configureBioSection() {
        let bioDescr = UILabel()
        bioDescr.text = userProfile.bio
        bioDescr.numberOfLines = 0
        bioDescr.textColor = .label
        bioDescr.font = .systemFont(ofSize: 16)
        
        bioStackView.addArrangedSubview(bioDescr)
    }
    
    private func configureStatisticsSection() {
        let followersStatView = makeStatView(count: String(userProfile.followerCount), label: "Followers")
        let followingStatView = makeStatView(count: String(userProfile.followingCount), label: "Following")
        let postsStatView = makeStatView(count: String(userProfile.postsCount), label: "Posts")
        
        statisticsStackView.addArrangedSubview(followersStatView)
        statisticsStackView.addArrangedSubview(followingStatView)
        statisticsStackView.addArrangedSubview(postsStatView)
    }
    
    private func makeStatView(count: String, label: String) -> UIStackView {
        let countLabel = UILabel()
        countLabel.text = count
        countLabel.textColor = .label
        countLabel.font = .systemFont(ofSize: 16)
        
        let textLabel = UILabel()
        textLabel.text = label
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 12)
        
        let stackView = UIStackView(arrangedSubviews: [countLabel, textLabel])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        
        return stackView
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.configuration = config
        return button
    }
    
    @objc private func addTaggedSection() {
        guard self.taggedPostsStackView == nil else {return}
        
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .center
        sv.isHidden = true
        
        let label = UILabel()
        label.textColor = .label
        label.text = "Tagged Posts Section"
        
        let button1 = createButton(title: "Toggle User Info")
        button1.addTarget(self, action: #selector(toggleUserInfo), for: .touchUpInside)
        let button2 = createButton(title: "Toggle Bio")
        button2.addTarget(self, action: #selector(toggleBio), for: .touchUpInside)

        sv.addArrangedSubview(label)
        sv.addArrangedSubview(button1)
        sv.addArrangedSubview(button2)
        
        self.taggedPostsStackView = sv
        self.mainLayoutStackView.addArrangedSubview(sv)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.taggedPostsStackView?.isHidden = false
        })
    }
    
    @objc private func toggleUserInfo() {
        UIView.animate(withDuration: 0.2, animations: {
            self.userInfoStackView.isHidden.toggle()
        })
    }
    
    @objc private func toggleBio() {
        UIView.animate(withDuration: 0.2, animations: {
            self.bioStackView.isHidden.toggle()
        })
    }
}
