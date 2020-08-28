//
//  ProfileViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 23/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signOutTapped(_ sender: UIButton) {
        createAlert(title: "Are you sure you want to sign out?", message: "")
    }
    
    func transitionToHome() {
        
        let controlViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.controlViewController)
        
        view.window?.rootViewController = controlViewController
        view.window?.makeKeyAndVisible()
    }
    
    func createAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (action) in
            do {
                try Auth.auth().signOut()
                self.transitionToHome()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
