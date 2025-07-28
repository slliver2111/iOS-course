//
//  ViewController.swift
//  5a. Task 1
//
//  Created by Artur Bednarz on 28/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customQueue = OperationQueue()
        let operation1 = BlockOperation{
            self.heavyOperation()
        }
        customQueue.addOperations([operation1], waitUntilFinished: false)
        
        OperationQueue.main.addOperation {
            self.heavyOperation()
        }
    }
    
    func heavyOperation() {
        print("Operation \"A\" started")
        for _ in 0..<1000000 {
            // do nothing
        }
        print("Operation \"A\" finished")
    }
}

