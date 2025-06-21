//
//  ViewController.swift
//  4. Image Display
//
//  Created by Artur Bednarz on 21/06/2025.
//

import UIKit

class ViewControllerScroll: UIViewController, UIScrollViewDelegate {
    let scrollView = UIScrollView()
    let imageView = UIImageView(image: UIImage(named: "test.png"))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        scrollView.delegate = self

        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0

        scrollView.addSubview(imageView)
        imageView.frame = scrollView.bounds
        imageView.contentMode = .scaleAspectFit
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}

