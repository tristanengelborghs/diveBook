//
//  RegistrationViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 23/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import Firebase
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
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        refresh()
        setUpElements()
    }
    
    func setUpElements() {
        //hide error label
        errorLabel.alpha = 0
        
        //style elements
        firstNameTextField.setBottomBorder(withColor: UIColor.black)
        lastNameTextField.setBottomBorder(withColor: UIColor.black)
        emailTextField.setBottomBorder(withColor: UIColor.black)
        passwordTextField.setBottomBorder(withColor: UIColor.black)
        Utilities.styleFilledButton(signUpButton)
        
        firstNameTextField.returnKeyType = .next
        lastNameTextField.returnKeyType = .next
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .continue
        passwordTextField.leftViewMode = .always
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        
        print(firstNameTextField.frame.width)
        
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
                    
//                    db.collection("users").document("\(result!.user.uid)").collection("Cards").document("Primary").setData([
//                        "Organistation": "",
//                        "Name": "Add your license here",
//                        "Date": "",
//                        "ID": 0,
//                        "DiveClub": "",
//                        "Primary": true ]) { (error) in
//                            
//                            if error != nil {
//                                //there was an error
//                                self.showError("There was a problem saving user data")
//                            }
//                    }
                    
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

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            signUpTapped(signUpButton)
        }
        
        
        return true
    }
}
