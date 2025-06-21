import UIKit

class ViewControllerTransparent: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        // 1. --- Add some interactive views to the background ---

        // A label to provide instructions.
        let infoLabel = UILabel()
        infoLabel.text = "You can interact with the button and slider.\nTap the overlay to change its color."
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.textColor = .black
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)

        // A button that shows an alert when tapped.
        let testButton = UIButton(type: .system)
        testButton.setTitle("Tap Me!", for: .normal)
        testButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        testButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        testButton.backgroundColor = .systemBlue
        testButton.setTitleColor(.white, for: .normal)
        testButton.layer.cornerRadius = 8
        testButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testButton)

        // A slider that can be moved.
        let testSlider = UISlider()
        testSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testSlider)
        
        // --- Layout the background views ---
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            testButton.widthAnchor.constraint(equalToConstant: 200),
            testButton.heightAnchor.constraint(equalToConstant: 50),

            testSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testSlider.topAnchor.constraint(equalTo: testButton.bottomAnchor, constant: 40),
            testSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])

        // 2. --- Create and configure the passthrough overlay view ---

        let overlayView = PassthroughView(frame: view.bounds)
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlayView.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        view.addSubview(overlayView)

        // Add a tap gesture to the overlay.
        // When tapped, it will randomly change its background color.
        overlayView.addTapGesture { [weak overlayView] in
            let randomColor = UIColor(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 0.2
            )
            overlayView?.backgroundColor = randomColor
            print("Overlay tapped!")
        }
    }

    // Action for the button tap.
    @objc private func buttonTapped() {
        print("Button underneath was tapped!")
        // For a real app, you might present an alert or perform another action.
        let alert = UIAlertController(title: "Button Tapped", message: "The touch passed through the overlay!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
