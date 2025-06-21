//
//  ViewController.swift
//  4. Image Display
//
//  Created by Artur Bednarz on 21/06/2025.
//

import UIKit

class ViewControllerContentSize: UIViewController, UIScrollViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .lightGray
        view.addSubview(scrollView)

        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1500))
        contentView.backgroundColor = .blue
        scrollView.addSubview(contentView)

        scrollView.contentSize = contentView.frame.size

    }
}

