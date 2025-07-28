//
//  ViewController.swift
//  5c. Task 3
//
//  Created by Artur Bednarz on 28/07/2025.
//

import UIKit

class ViewController: UIViewController {
    let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oprB = BlockOperation {
            print("Operation B started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation B finished")
            
        }
        
        let oprA = BlockOperation {
            print("Operation A started")
            oprB.cancel()
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation A finished")
            
        }
        
        //oprB.addDependency(oprA)
        queue.addOperations([oprA, oprB], waitUntilFinished: false)
    }
}

// Difference are: in the first case operation B was never started and finished. In second both operations A and B were started and finished. Apparently oprB.cancel() in oprA scope doesn't impact oprB running unless there is dependency operation created.

