import UIKit

class OnboardingViewController: UIViewController {
    private let myButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Onboarding"
        setupView()
        setupConstraints()
    }
    
    
    private func setupView() {
        setupButton()
    }
    
    
    private func setupButton() {
        var config = UIButton.Configuration.filled()
        config.title = "Start"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        config.cornerStyle = .dynamic
        myButton.configuration = config
        myButton.addTarget(self, action: #selector(addTapped(_ :)), for: .touchUpInside)
        
        view.addSubview(myButton)
    }
    
    private func setupConstraints() {
        setupButtonConstraints()
    }
    
    
    private func setupButtonConstraints() {
        myButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
    }
    
    @objc func addTapped(_ sender: UIButton) {
        let personalInfoVC = PersonalInfoViewController()
        navigationController?.pushViewController(personalInfoVC, animated: false)
    }
}
