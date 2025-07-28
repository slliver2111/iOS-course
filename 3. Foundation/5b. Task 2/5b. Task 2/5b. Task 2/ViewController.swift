//
//  ViewController.swift
//  5b. Task 2
//
//  Created by Artur Bednarz on 28/07/2025.
//

import UIKit

class ViewController: UIViewController {
    let operationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oprA = heavyOperation(name: "A")
        let oprB = heavyOperation(name: "B")
        let oprC = heavyOperation(name: "C")
        let oprD = heavyOperation(name: "D")
        
        // MARK: 1 exercise
//        operationQueue.maxConcurrentOperationCount = 6
//        operationQueue.addOperations([oprA, oprB, oprC, oprD], waitUntilFinished: false)
        
        // MARK: 2 exercise
//        operationQueue.maxConcurrentOperationCount = 2
//        operationQueue.addOperations([oprA, oprB, oprC, oprD], waitUntilFinished: false)
        
        // MARK: 3 exercise
//        oprB.addDependency(oprC)
//        oprD.addDependency(oprB)
//        operationQueue.addOperations([oprA, oprB, oprC, oprD], waitUntilFinished: false)
        
        // MARK: 4 exercise
        oprA.queuePriority = .low
        operationQueue.addOperations([oprA, oprB, oprC, oprD], waitUntilFinished: false)
    }
    
    func heavyOperation(name: String) -> BlockOperation {
        return BlockOperation {
            print("Operation \(name) started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \(name) finished")
        }
    }
    
}

