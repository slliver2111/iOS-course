import UIKit

class PersonalInfoViewController: UIViewController {
    private let nameField = UITextField()
    private let phoneField = UITextField()
    private let confirmButton = UIButton()
    private var userAlert: UIAlertController!
    private let contentView = UIView()
    
    var userData: UserData
    
    init (userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personal info"
        setupView()
        setupAlert()
    }
    
    private func setupView() {
        setupContentView()
        setupTextFields()
        setupButton()
        setupConstraints()
    }
    
    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
    }
    
    
    private func setupTextFields() {
        nameField.placeholder = "Enter Name"
        nameField.text = userData.name
        nameField.borderStyle = .roundedRect
        nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phoneField.placeholder = "Enter Phone Number"
        phoneField.text = userData.phoneNumber
        phoneField.borderStyle = .roundedRect
        phoneField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phoneField.keyboardType = .phonePad
        
        contentView.addSubview(nameField)
        contentView.addSubview(phoneField)
    }
    
    private func setupButton() {
        var config = UIButton.Configuration.filled()
        config.title = "Confirm"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        config.cornerStyle = .dynamic
        confirmButton.configuration = config
        confirmButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        confirmButton.isEnabled = checkIfFieldsAreCorrect()
        confirmButton.addTarget(self, action: #selector(confirmTapped(_ :)), for: .touchUpInside)
        
        contentView.addSubview(confirmButton)
    }
    
    private func setupConstraints() {
        setupContentViewConstraints()
        setupTextFieldsConstraints()
        setupButtonConstraints()
    }
    
    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate(
            [
                contentView.topAnchor.constraint(equalTo: view.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                contentView.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor, constant: -20),
            ]
        )
    }
    
    private func setupTextFieldsConstraints() {
        nameField.translatesAutoresizingMaskIntoConstraints = false
        phoneField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 40),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            phoneField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            phoneField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            phoneField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor)
        ])
    }
    
    private func setupButtonConstraints() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 16),
            confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            confirmButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupAlert() {
        userAlert = UIAlertController(title: "Confirm Information", message: nil, preferredStyle: .alert)
        userAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {_ in self.proceedNextPage()}))
        userAlert.addAction(UIAlertAction(title: "Edit", style: .cancel, handler: nil))
    }
    
    private func updateAlert() {
        userAlert.message = "Please confirm your name and phone number. Name: \(nameField.text ?? ""), Phone: \(phoneField.text ?? "")."
    }
    
    private func checkIfFieldsAreCorrect() -> Bool {
        if let nameText = nameField.text, let numberText = phoneField.text {
            return !nameText.isEmpty && numberText.count >= 9
        }
        return false
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        confirmButton.isEnabled = checkIfFieldsAreCorrect()
    }
    
    @objc private func confirmTapped(_ sender: UIButton) {
        updateAlert()
        updateUserDataCollection()
        present(userAlert, animated: true)
    }
    
    private func proceedNextPage() {
        let preferencesVC = PreferencesViewController(userData: userData)
        navigationController?.pushViewController(preferencesVC, animated: false)
    }
    
    private func updateUserDataCollection() {
        userData.name = nameField.text ?? ""
        userData.phoneNumber = phoneField.text ?? ""
    }
}

#Preview {
    PersonalInfoViewController(userData: UserData())
}
