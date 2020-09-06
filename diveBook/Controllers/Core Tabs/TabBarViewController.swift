//
//  TabBarViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 24/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import FirebaseAuth

class TabBarViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUser()
    }

    func checkUser() {
    
    if Auth.auth().currentUser == nil {
        DispatchQueue.main.async {
            let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.controlViewController)

            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    }
}
