//
//  4. Gestures.swift
//  4. Image Display
//
//  Created by Artur Bednarz on 21/06/2025.
//

import UIKit

class ViewControllerGestures: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let box = UIView(frame: CGRect(x: 100, y: 100, width: 150, height: 150))
        box.backgroundColor = .systemBlue
        view.addSubview(box)

        // Pan
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        box.addGestureRecognizer(pan)
    }

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        gesture.view?.center = CGPoint(
            x: gesture.view!.center.x + translation.x,
            y: gesture.view!.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
    }

}

