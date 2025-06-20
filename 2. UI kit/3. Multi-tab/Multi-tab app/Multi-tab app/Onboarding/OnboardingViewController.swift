import UIKit

class OnboardingViewController: UIViewController {
    let userData: UserData
    private let contentView = UIView()
    
    init (userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Onboarding"
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateButton()
    }
    
    private let myButton = UIButton()
    
    private func setupView() {
        setupContentView()
        setupButton()
    }
    
    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
    }
    
    private func setupButton() {
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.configuration = createButtonConfig()
        myButton.addTarget(self, action: #selector(addTapped(_ :)), for: .touchUpInside)
        contentView.addSubview(myButton)
    }
    
    private func updateButton() {
        myButton.configuration = createButtonConfig()
    }
    
    private func createButtonConfig() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = userData.onBoardingFinished ? "Restart" : "Start"
        config.baseBackgroundColor = userData.onBoardingFinished ? .systemGreen : .systemBlue
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        config.cornerStyle = .dynamic
        return config
    }

    
    private func setupConstraints() {
        setupContentViewConstraints()
        setupButtonConstraints()
    }
    
    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate(
            [
                contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ]
        )
    }
    
    
    private func setupButtonConstraints() {
        NSLayoutConstraint.activate([
            myButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            myButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            myButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    @objc func addTapped(_ sender: UIButton) {
        let personalInfoVC = PersonalInfoViewController(userData: userData)
        navigationController?.pushViewController(personalInfoVC, animated: false)
    }
}



#Preview {
    OnboardingViewController(userData: UserData())
}
