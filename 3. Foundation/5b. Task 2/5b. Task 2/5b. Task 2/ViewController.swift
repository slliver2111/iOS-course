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
        oprB.addDependency(oprC)
        oprD.addDependency(oprB)
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

//Case 1: Start of operations in the order. Random finish of them.
//Case 2: Only 2 operations are allowed to work at the same time. Once a slot is free, another operation is started.
//Case 3: Only operations C and A are allowed to begin. Once the C is completed the B starts operation. Same with operations D. As result operation D is the very last one to start and finish.
//Case 4: With .low queue priority operations A seems to be lazy. Everytime this test was performed operation A started after operation C is finished and B was started.
