import UIKit

class PersonalInfoViewController: UIViewController {
    private let nameField = UITextField()
    private let numberField = UITextField()
    private let confirmButton = UIButton()
    private let userAlert = UIAlertController()
    
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personal info"
        setupView()
        //setupAlert()
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
        
        NSLayoutConstraint.activate(
            [
                contentView.topAnchor.constraint(equalTo: view.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                contentView.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor, constant: -20),
            ]
        )
    }
    
    
    private func setupTextFields() {
        nameField.placeholder = "Enter Name"
        nameField.borderStyle = .roundedRect
        nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        numberField.placeholder = "Enter Phone Number"
        numberField.borderStyle = .roundedRect
        numberField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        contentView.addSubview(nameField)
        contentView.addSubview(numberField)
    }
    
    private func setupButton() {
        var config = UIButton.Configuration.filled()
        config.title = "Confirm"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        config.cornerStyle = .dynamic
        confirmButton.configuration = config
        confirmButton.isEnabled = false
        confirmButton.addTarget(self, action: #selector(confirmTapped(_ :)), for: .touchUpInside)
        
        contentView.addSubview(confirmButton)
    }
    
    private func setupConstraints() {
        setupTextFieldsConstraints()
        setupButtonConstraints()
    }
    
    private func setupTextFieldsConstraints() {
        nameField.translatesAutoresizingMaskIntoConstraints = false
        numberField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 40),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            numberField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            numberField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            numberField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor)
        ])
    }
    
    private func setupButtonConstraints() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: numberField.bottomAnchor, constant: 16),
            confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            confirmButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupAlert() {
        userAlert.title = "Confirm Information"
        userAlert.message = "Please confirm your name and phone number.\nName: \(nameField.text ?? ""), \nPhone: \(numberField.text ?? "")."
        userAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {_ in self.proceedNextPage()}))
        userAlert.addAction(UIAlertAction(title: "Edit", style: .default, handler: nil))
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        if let nameText = nameField.text, let numberText = numberField.text {
            confirmButton.isEnabled = !nameText.isEmpty && numberText.count >= 9
        }
    }
    
    @objc private func confirmTapped(_ sender: UIButton) {
        setupAlert()
        present(userAlert, animated: true)
    }
    
    private func proceedNextPage() {
        let personalInfoVC = PersonalInfoViewController()
        navigationController?.pushViewController(personalInfoVC, animated: false)
    }
}

#Preview {
    PersonalInfoViewController()
}
