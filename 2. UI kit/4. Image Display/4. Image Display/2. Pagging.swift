//
//  ViewController.swift
//  4. Image Display
//
//  Created by Artur Bednarz on 21/06/2025.
//

import UIKit

class ViewControllerPagging: UIViewController, UIScrollViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: view.frame.height)
        view.addSubview(scrollView)
        
        for i in 0..<3 {
            let page = UIView(frame: CGRect(
                x: CGFloat(i) * view.frame.width,
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            ))
            page.backgroundColor = [UIColor.red, .green, .blue][i]
            scrollView.addSubview(page)
        }
    }
}

