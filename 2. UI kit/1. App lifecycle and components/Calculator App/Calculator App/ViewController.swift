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
        createCalculatorLabel()
    }
    
    private let mainLabel = UILabel()
    
    private var currentInput: String = ""
    private var previousValue: Double? = nil
    private var currentOperator: String? = nil
    private var clearInput: Bool = false
    
    private let gridButtons = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["C", "0", "=", "+"]
    ]
    
    let width: Double = 90.0
    let height: Double = 100.0
    let paddingx: Double = 1.0
    let paddingy: Double = 1.0
    let offsetx: Double = 10.0
    let offsety: Double = 300.0
    
    func createCalculatorLabel() {
        // Customize main label
        mainLabel.frame = CGRect(x: offsetx, y: offsety, width: 4 * width + 3 * paddingy, height: height)
        mainLabel.text = "0"
        mainLabel.textColor = .systemBlue
        mainLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        mainLabel.textAlignment = .right
        mainLabel.backgroundColor = .white
        mainLabel.numberOfLines = 1
        view.addSubview(mainLabel)
        
    }
    
    func createCalculatorButtons() {
        // Create buttons grid
        for (i,row) in gridButtons.enumerated() {
            for (j,el) in row.enumerated() {
                let x: CGFloat = Double(j) * (width + paddingx) + offsetx
                let y: CGFloat = Double(i) * (height + paddingy) + offsety + height + paddingy
                let button = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
                button.setTitle(el, for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemBlue
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                view.addSubview(button)
            }
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        switch title {
        case "0"..."9":
            handleNumber(title)
        case "+", "-", "*", "/":
            handleOperator(title)
        case "=":
            handleEqual()
        case "C":
            handleReset()
        default:
            break
        }
    }
    
    private func handleNumber(_ num : String) {
        if clearInput {
            currentInput = ""
            clearInput = false
        }
    
        // Preventing inputs like: 00001
        if num == "0" && currentInput == "0" {
            return
        } else if currentInput == "0" && num != "0" {
            currentInput = num
        } else {
            currentInput += num
        }
        mainLabel.text = currentInput
    }
    
    private func handleOperator(_ op: String) {
        currentOperator = op
        previousValue = Double(currentInput)
        currentInput = ""
        clearInput = false
    }
    
    private func handleEqual() {
        guard let prevVal = previousValue else { print("firstVal error"); return }
        guard let currVal =  Double(currentInput) else { print("second val error"); return }
        var result: Double? = nil
        switch currentOperator {
        case "+":
            result = prevVal + currVal
        case "-":
            result = prevVal - currVal
        case "*":
            result = prevVal * currVal
        case "/":
            result = currVal == 0 ? nil : prevVal / currVal
        default:
            result = nil
        }
        
        // Remove suffix .0 if presents
        if let result = result {
            let intResult: Int = Int(result)
            mainLabel.text = Double(intResult) == result ? String(intResult) : String(result)
        } else {
            mainLabel.text = "Undefined"
        }
        
        // Reset
        currentInput = ""
        previousValue = nil
        currentOperator = nil
        clearInput = true
    }
    
    private func handleReset() {
        currentInput = ""
        mainLabel.text = "0"
        previousValue = nil
        clearInput = false
    }
}
