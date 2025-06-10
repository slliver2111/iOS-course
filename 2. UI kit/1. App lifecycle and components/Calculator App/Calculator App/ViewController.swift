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
    
    private let mainLabel = UILabel()
    
    private let gridButtons: [String] = [
        "7", "8", "9", "/",
        "4", "5", "6", "*",
        "1", "2", "3", "-",
        "C", "0", "=", "+"
    ]
    
    func createCalculatorButtons() {
        let width: Double = 90.0
        let height: Double = 100.0
        let paddingx: Double = 1.0
        let paddingy: Double = 1.0
        let offsetx: Double = 10.0
        let offsety: Double = 300.0
        
        // Customize main label
        mainLabel.frame = CGRect(x: offsetx, y: offsety, width: 4 * width + 3 * paddingy, height: height)
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
                let x: CGFloat = Double(j) * (width + paddingx) + offsetx
                let y: CGFloat = Double(i) * (height + paddingy) + offsety + height + paddingy
                let button = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
                button.setTitle(gridButtons[i*4+j], for: .normal)
                button.tag = i*4+j+1
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemBlue
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                view.addSubview(button)
            }
        }
    }
    
    private var operatorToUse: OperationType = .idle
    private var firstNumberToUse: Int?
    private var secondNumberToUse: Int?
    
    enum OperationType {
        case add, sub, multi, divide, idle
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        
    }
    
//    @objc func buttonTapped(_ sender: UIButton) {
//        // Delete action
//        if sender.tag == 13 && mainLabel.text?.isEmpty == false {
//            mainLabel.text = "0"
//            operatorToUse = .idle
//            firstNumberToUse = nil
//            secondNumberToUse = nil
//        }
//        
//        // Calculate action using Expression framework
//        else if sender.tag == 15, let num1 = firstNumberToUse, let num2 = secondNumberToUse  {
//            switch operatorToUse {
//            case .add:
//                mainLabel.text = String(firstNumberToUse! + secondNumberToUse!)
//            case .sub:
//                mainLabel.text = String(firstNumberToUse! - secondNumberToUse!)
//            case .multi:
//                mainLabel.text = String(firstNumberToUse! * secondNumberToUse!)
//            case .divide:
//                mainLabel.text = String(Double(firstNumberToUse!) / Double(secondNumberToUse!))
//            case .idle:
//                print("test")
//            }
//        }
//        
//        // Other normal action
//        else if let newText = gridButtons[sender.tag], let oldText = mainLabel.text {
//            mainLabel.text = ((oldText == "0" || oldText == "Undefined") ? "" : oldText) + newText
//        }
//    }
}
