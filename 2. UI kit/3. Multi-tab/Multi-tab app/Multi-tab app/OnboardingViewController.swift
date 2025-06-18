import UIKit

class OnboardingViewController: UINavigationController {
    private let titleLabel = UILabel()
    private let myButton = UIButton(type: .system)
    private let personalInfoVC = PersonallnfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    
    private func setupView() {
        setupLabel()
        setupButton()
    }
    
    
    private func setupLabel() {
        titleLabel.text = "My label"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        view.addSubview(titleLabel)
    }
    
    private func setupButton() {
        myButton.setTitle("Start", for: .normal)
        myButton.backgroundColor = .systemBlue
        myButton.layer.cornerRadius = 10
        myButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 25, bottom: 12, trailing: 25)
        config.cornerStyle = .dynamic
        myButton.configuration = config
        
        view.addSubview(myButton)
    }
    
    private func setupConstraints() {
        setupLabelsConstraints()
        setupButtonConstraints()
    }
    
    private func setupLabelsConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ]
        )
    }
    
    
    private func setupButtonConstraints() {
        myButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        self.pushViewController(personalInfoVC, animated: true)
    }
}
