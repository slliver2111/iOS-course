import UIKit

// Build a UI programmatically with a UIButton positioned below a UILabel.
// The button should be centered horizontally and have a fixed distance from the label.
// Adjust the layout to handle different screen sizes.
final class Task2ViewController: UIViewController {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "My label"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let myButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("My button", for: .normal)
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 25, bottom: 12, trailing: 25)
        config.cornerStyle = .large
        myButton.configuration = config
        myButton.translatesAutoresizingMaskIntoConstraints = false
        return myButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(myButton)
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                myButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                myButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ]
        )
    }
}

#Preview {
    Task2ViewController()
}
