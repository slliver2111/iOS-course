//
//  EditProfileViewController.swift
//  Multi-tab app
//
//  Created by Artur Bednarz on 20/06/2025.
//

import UIKit

class EditProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Edit profile"
        log("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           log("viewWillAppear")
       }

       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           log("viewDidAppear")
       }

       override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
           log("viewWillLayoutSubviews")
       }

       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           log("viewDidLayoutSubviews")
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           log("viewWillDisappear")
       }

       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           log("viewDidDisappear")
       }

       private func log(_ methodName: String) {
           let now = Date()
           print("Edit LOG: \(methodName) : \(now)")
       }

}
