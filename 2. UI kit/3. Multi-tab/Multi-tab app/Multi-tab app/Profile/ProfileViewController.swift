import UIKit

class ProfileViewController: UIViewController {
    private var username: String = "" {
        didSet {
            textField.text = username
        }
    }
    
    private let textField: UILabel = {
        let text = UILabel()
        text.text = ""
        text.font = .systemFont(ofSize: 24, weight: .bold)
        text.textAlignment = .center
        return text
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Edit profile"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        button.configuration = config
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"
        username = "John"
        setupLayout()
        setupNavBar()
        editButton.addTarget(self,action: #selector(editButtonTapped), for: .touchUpInside)
        log("viewDidLoad")
    }
    
    private func setupLayout() {
        editButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(editButton)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            editButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupNavBar() {
        let button1 = UIBarButtonItem(image: UIImage(systemName: "pencil.slash"), style: .plain, target: self, action: #selector(pencilTapped))
        let button2 = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .plain, target: self, action: #selector(personTapped))
        navigationItem.rightBarButtonItems = [button1, button2]
    }
    
    @objc func editButtonTapped() {
        let editVC = EditProfileViewController()
        navigationController?.pushViewController(editVC, animated: false)
    }
    
    @objc func pencilTapped() {
        let alert = UIAlertController(title: "Edit name", message: "Enter your new name", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {text in text.placeholder = "Type your name here"})
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in self.username = alert.textFields?.first?.text ?? ""}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func personTapped() {
        username = "Anonymous"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        log("viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        log("viewDidAppear")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        log("viewWillLayoutSubviews")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        log("viewDidLayoutSubviews")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        log("viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        log("viewDidDisappear")
    }

    private func log(_ methodName: String) {
        let now = Date()
        print("Profile LOG: \(methodName) : \(now)")
    }
}

#Preview {
    ProfileViewController()
}
