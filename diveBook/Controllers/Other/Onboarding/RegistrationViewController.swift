//
//  RegistrationViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 23/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    //setup background
    let colors = Colors()

    func refresh() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer!.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
        setUpElements()
    }
    
    func setUpElements() {
        
        //hide error label
        errorLabel.alpha = 0
        
        //style elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    
    }
    
    //returns nil when ok and error message when not valid
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if  firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        //validate the fields
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
        
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
                //check for errors
                if err != nil {
                    //there was an error
                    self.showError("Error creating user")
                }
                else {
                    //user was created succesfull
                    let db = Firestore.firestore()
                
                    db.collection("users").document("\(result!.user.uid)").setData([
                        "First name": firstName,
                        "Last name": lastName,
                        "Email": email,
                        "uid": result!.user.uid ]) { (error) in
                            
                            if error != nil {
                                //there was an error
                                self.showError("There was a problem saving user data")
                            }
                    }
                    
                    //transition to the home screen
                    self.performSegue(withIdentifier: "toHome", sender: self)
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
