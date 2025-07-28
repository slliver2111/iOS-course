//
//  ViewController.swift
//  5a. Task 1
//
//  Created by Artur Bednarz on 28/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    let customQueue = OperationQueue()
    let runButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        runButton.setTitle("Run heavy task", for: .normal)
        runButton.frame = CGRect(origin: .zero, size: CGSize(width: 400, height: 100))
        runButton.center = view.center
        runButton.addTarget(self, action: #selector(runButtonTapped), for: .touchUpInside)
        view.addSubview(runButton)
    }
    
    @objc func runButtonTapped() {
        OperationQueue.main.addOperation {
            self.heavyOperationA()
        }
        
        let backgroundOperation = BlockOperation {
            self.heavyOperationB()
        }
        customQueue.addOperation(backgroundOperation)
    }
    
    func heavyOperationA() {
        print("Operation \"A\" started")
        for _ in 0..<100000000 {
            // do nothing
        }
        print("Operation \"A\" finished")
    }
    
    func heavyOperationB() {
        print("Operation \"B\" started")
        for _ in 0..<100000000 {
            // do nothing
        }
        print("Operation \"B\" finished")
    }
}

//Answer:
//
//"OperationQueue.main" runs on main thread (Thread 1). This blocks UI making an app freeze and unresponsive.
//
//"OperationQueue" runs on background thread (Thread 8). This does not block the UI remaining  the app responsive while the heave work is performed in the background.
