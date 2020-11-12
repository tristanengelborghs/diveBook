//
//  SplashViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 03/09/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed

        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.firstViewController)

                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        } else {
            DispatchQueue.main.async {
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)

                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }

}
