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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
