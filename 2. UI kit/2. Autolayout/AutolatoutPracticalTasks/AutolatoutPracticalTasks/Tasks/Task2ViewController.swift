import UIKit

// Build a UI programmatically with a UIButton positioned below a UILabel.
// The button should be centered horizontally and have a fixed distance from the label.
// Adjust the layout to handle different screen sizes.
final class Task2ViewController: UIViewController {
    private let titleLabel = UILabel()
    private let myButton = UIButton(type: .system)
    
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
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
    }
    
    private func setupButton() {
        myButton.setTitle("My button", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.backgroundColor = .systemBlue
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
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
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
}
