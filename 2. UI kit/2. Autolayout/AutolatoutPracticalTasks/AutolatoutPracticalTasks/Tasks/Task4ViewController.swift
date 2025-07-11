//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.
final class Task4ViewController: UIViewController {
    
    private let view1 = UIView()
    private let view2 = UIView()
    
    private enum LayoutDirection {
        case vertical
        case compact
        
        static func get(_ traitCollection: UITraitCollection) -> Self {
            if traitCollection.horizontalSizeClass == .compact,
                traitCollection.verticalSizeClass == .compact {
                return .compact
            } else {
                return .vertical
            }
        }
    }
    
    private var constraintsVertical: [NSLayoutConstraint] = []
    private var constraintsCompact: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForTraitChanges()
        setupViews()
        setupConstraints()
        updateConstraints()
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            print("Trait collection changed:", self.traitCollection)
            self.updateConstraints()
        }
    }
    
    private func setupConstraints() {
        constraintsVertical = [
            view1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            view2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 10.0),
            view2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            view1.heightAnchor.constraint(equalTo: view2.heightAnchor)
        ]
        
        constraintsCompact = [
            view1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            view2.leadingAnchor.constraint(equalTo: view1.trailingAnchor, constant: 10.0),
            view2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            view1.widthAnchor.constraint(equalTo: view2.widthAnchor)
        ]
    }
    
    private func updateConstraints() {
        NSLayoutConstraint.deactivate(constraintsVertical)
        NSLayoutConstraint.deactivate(constraintsCompact)
        
        switch LayoutDirection.get(self.traitCollection) {
            case .compact:
                NSLayoutConstraint.activate(constraintsCompact)
            case .vertical:
                NSLayoutConstraint.activate(constraintsVertical)
        }
    }
    
    private func setupViews() {
        view1.backgroundColor = .systemRed
        view2.backgroundColor = .systemGreen
        
        [view1, view2].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 20
            view.addSubview($0)
        }
    }
}

#Preview {
    Task4ViewController()
}
