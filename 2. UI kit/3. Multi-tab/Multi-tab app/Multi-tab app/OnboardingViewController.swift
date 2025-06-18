import UIKit

class OnboardingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemGray
        title = "Onboarding"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:))
        )
    }
    
    @objc func addTapped(_ sender: UIButton) {}
}
