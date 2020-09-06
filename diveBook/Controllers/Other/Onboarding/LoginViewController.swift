//
//  LoginViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 23/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let colors = Colors()

    func refresh() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer!.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //refresh()
        setUpElements()
    }
    
    func setUpElements() {
        
        //hide error label
        errorLabel.alpha = 0
        
        //style elements
        emailTextField.setBottomBorder(withColor: UIColor.black)
        passwordTextField.setBottomBorder(withColor: UIColor.black)
        Utilities.styleFilledButton(loginButton)
        
    }
    
    //returns nil when ok and error message when not valid
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
            // Create cleaned versions of the text field
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
                if error != nil {
                    self.showError(error!.localizedDescription)
                }
                else {
                    //transition to the home screen
                    self.performSegue(withIdentifier: "ToHome", sender: self)
                }
            }
        }
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
