//
//  FirstViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 24/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirstViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    
    let colors = Colors()

    func refresh() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer!.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.setUpElements()
            self.refresh()
        }
    }
    
    func checkUser() {
    if Auth.auth().currentUser != nil {
        DispatchQueue.main.async {
            let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)

            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    }

    //Style elements
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(logInButton)
    }
}
