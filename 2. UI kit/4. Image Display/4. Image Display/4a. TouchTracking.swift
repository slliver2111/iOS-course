//
//  4a. TouchTracking.swift
//  4. Image Display
//
//  Created by Artur Bednarz on 21/06/2025.
//

import UIKit

class ViewControllerTouchTracking: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewA = TouchTrackingView(name: "ViewA", frame: CGRect(x: 40, y: 100, width: 300, height: 300), color: .systemRed)
        let viewB = TouchTrackingView(name: "ViewB", frame: CGRect(x: 50, y: 50, width: 200, height: 200), color: .systemGreen)
        let viewC = TouchTrackingView(name: "ViewC", frame: CGRect(x: 30, y: 30, width: 100, height: 100), color: .systemBlue)
        viewC.isUserInteractionEnabled = false

        // Nesting: C inside B inside A
        viewB.addSubview(viewC)
        viewA.addSubview(viewB)
        view.addSubview(viewA)
    }
}

