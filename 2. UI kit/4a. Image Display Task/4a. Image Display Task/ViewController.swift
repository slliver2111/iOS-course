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

class ImageScrollViewController: UIViewController, UIScrollViewDelegate {

    private let scrollView = UIScrollView()
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupImageView()
        setupConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            updateZoomScale()
        }
    }

    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
    }

    private func setupImageView() {
        if let image = UIImage(named: "test") {
            imageView.image = image
            //imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(origin: .zero, size: image.size)
            scrollView.contentSize = image.size
            scrollView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    //zoom logic
    private func updateZoomScale() {
        let scrollViewBounds = scrollView.bounds
        let imageSize = imageView.bounds.size
        let availableWidth = scrollViewBounds.width - 20 * 2 //20px padding
        let availableHeight = scrollViewBounds.height - 20 * 2
        let widthScale = availableWidth / imageSize.width
        let heightScale = availableHeight / imageSize.height
        let scale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = scale
        scrollView.maximumZoomScale = 5.0
        scrollView.zoomScale = scale
        print("zoom logic")
    }

    private func centerImage() {
        let boundsSize = scrollView.bounds.size
        let frameToCenter = imageView.frame
        let horizontalSpace = boundsSize.width - frameToCenter.size.width
        let verticalSpace = boundsSize.height - frameToCenter.size.height
        let horizontalOffset = max(0, horizontalSpace * 0.5)
        let verticalOffset = max(0, verticalSpace * 0.5)
        
        scrollView.contentInset = UIEdgeInsets(
            top: verticalOffset,
            left: horizontalOffset,
            bottom: verticalOffset,
            right: horizontalOffset
        )
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
}
