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
    }
    
    
    private func setupView() {
        setupLabel()
        setupButton()
        setupConstraints()
    }
    
    
    private func setupLabel() {
        titleLabel.text = "My label"
        titleLabel.font = .boldSystemFont(ofSize: 32)
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
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }
    
    
    private func setupButtonConstraints() {
        myButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
