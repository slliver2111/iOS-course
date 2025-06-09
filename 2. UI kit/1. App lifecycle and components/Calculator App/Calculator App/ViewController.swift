//
//  ViewController.swift
//  Calculator App
//
//  Created by Artur Bednarz on 05/06/2025.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createCalculatorButtons()
    }
    
    func createCalculatorButtons() {
        let rawWidth: Double = 90.0
        let rawHeight: Double = 100.0
        let paddingx: Double = 1.0
        let paddingy: Double = 1.0
        let offsetx: Double = 10.0
        let offsety: Double = 300.0
        
        let width: CGFloat = Double(rawWidth)
        let height: CGFloat = Double(rawHeight)
        
        let specialButtons: [Int: String] = [
            1: "1", 2: "2", 3: "3", 4: "/",
            5: "4", 6: "5", 7: "6", 8: "*",
            9: "7", 10: "8", 11: "9", 12: "-",
            13: "0", 14: "00", 15: "=", 16: "+",
        ]
        
        // Create buttons grid
        for i in 0...3 {
            for j in 0...3 {
                let x: CGFloat = Double(Double(j) * (rawWidth + paddingx) + offsetx)
                let y: CGFloat = Double(Double(i) * (rawHeight + paddingy) + offsety)
                let button = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
                
                let gridLocation = i*4+j+1
                if let title = specialButtons[gridLocation] {
                    button.setTitle(title, for: .normal)
                }
                
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemBlue
                view.addSubview(button)
            }
        }
    }

    @objc func buttonTapped() {
        print("Button was tapped!")
    }
}
