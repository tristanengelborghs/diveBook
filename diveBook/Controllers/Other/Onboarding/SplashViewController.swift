//
//  SplashViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 25/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "first", sender: self)
    }

    
    func checkUser() {
        if Auth.auth().currentUser != nil {
            let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)

            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
    
        } else {
            let controlViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.controlViewController)

            view.window?.rootViewController = controlViewController
            view.window?.makeKeyAndVisible()
        }
    }
}
