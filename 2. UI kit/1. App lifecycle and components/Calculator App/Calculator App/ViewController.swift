//
//  ViewController.swift
//  Calculator App
//
//  Created by Artur Bednarz on 05/06/2025.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createCalculatorButtons()
    }
    
    let mainLabel = UILabel()
    
    let gridButtons: [Int: String] = [
        1: "1", 2: "2", 3: "3", 4: "/",
        5: "4", 6: "5", 7: "6", 8: "*",
        9: "7", 10: "8", 11: "9", 12: "-",
        13: "CLR", 14: "0", 15: "=", 16: "+",
    ]
    
    func createCalculatorButtons() {
        let rawWidth: Double = 90.0
        let rawHeight: Double = 100.0
        let paddingx: Double = 1.0
        let paddingy: Double = 1.0
        let offsetx: Double = 10.0
        let offsety: Double = 300.0
        
        let width: CGFloat = Double(rawWidth)
        let height: CGFloat = Double(rawHeight)
        
        // Customize main label
        mainLabel.frame = CGRect(x: offsetx, y: offsety, width: 4 * rawWidth + 3 * paddingy, height: rawHeight)
        mainLabel.text = "0"
        mainLabel.textColor = .systemBlue
        mainLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        mainLabel.textAlignment = .right
        mainLabel.backgroundColor = .white
        mainLabel.numberOfLines = 1
        view.addSubview(mainLabel)
        
        // Create buttons grid
        for i in 0...3 {
            for j in 0...3 {
                let x: CGFloat = Double(Double(j) * (rawWidth + paddingx) + offsetx)
                let y: CGFloat = Double(Double(i) * (rawHeight + paddingy) + offsety + rawHeight + paddingy)
                let button = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
                
                let gridLocation = i*4+j+1
                if let title = gridButtons[gridLocation] {
                    button.setTitle(title, for: .normal)
                    button.tag = gridLocation
                }
                
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemBlue
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                view.addSubview(button)
            }
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Delete action
        if sender.tag == 13 && mainLabel.text?.isEmpty == false {
            mainLabel.text = "0"
        }
        
        // Calculate action
        else if sender.tag == 15, let input = mainLabel.text {
            let expression = Expression(input)
            do {
                let doubleResult = try expression.evaluate() // 11
                if doubleResult.isInfinite {
                    mainLabel.text = "Undefined"
                } else {
                    let intResult = Int(doubleResult)
                    if Double(intResult) == doubleResult {
                        mainLabel.text = String(intResult)
                    } else {
                        mainLabel.text = String(doubleResult)
                    }
                }
            } catch {
                print("Error")
            }
        }
        
        // Other action
        else if let newText = gridButtons[sender.tag], let oldText = mainLabel.text {
            mainLabel.text = ((oldText == "0" || oldText == "Undefined") ? "" : oldText) + newText
        }
    }
}
