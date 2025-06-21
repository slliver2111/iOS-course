//
//  ViewController.swift
//  4a. Image Display Task
//
//  Created by Artur Bednarz on 21/06/2025.
//

//You are tasked with implementing a UIScrollView that displays a large image. The scroll view should allow the user to scroll the image in both directions, with some custom padding and bounce behavior. However, the image should always stay centered even if the user zooms in or out.
//
//
//- Implement a UIScrollView to contain an image.
//- Ensure the contentSize of the scroll view is properly calculated for the image.
//- Implement UIScrollView to allow zooming (using the delegate method viewForZoomingInScrollView).
//- The scroll view should have padding of 20 points on all sides.
//- Disable scrolling on the horizontal axis, but allow vertical scrolling.
//- The image should always be centered, even after zooming in or out.

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let imageView = UIImageView(image: UIImage(named: "test"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ScrollView setup
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 3.0
        scrollView.bounces = true
        scrollView.showsHorizontalScrollIndicator = false
        
        // ImageView setup
        imageView.contentMode = .scaleAspectFill
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
    }
    
    // Enable zooming
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // Center the image after zooming
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage(in: scrollView)
    }

    private func centerImage(in scrollView: UIScrollView) {
        let boundsSize = scrollView.bounds.size
        let contentSize = scrollView.contentSize
        
        // Calculate horizontal and vertical padding to center content
        let horizontalInset = contentSize.width < boundsSize.width ? (boundsSize.width - contentSize.width) * 0.5 : 0
        let verticalInset = contentSize.height < boundsSize.height ? (boundsSize.height - contentSize.height) * 0.5 : 0
        
        // Apply centered insets (only when content is smaller than scroll view)
        scrollView.contentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        )
    }
}
