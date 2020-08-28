//
//  AuthManager.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 23/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        // check email
        DatabaseManager.shared.canCreateNewUser(with: email) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        // firebase could not create account
                        completion(false)
                        return
                    }
                    // insert into database
                    DatabaseManager.shared.insertNewUser(with: email) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            //failed to insert into database
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                // email does not exist
                completion(false)
            }
        }
        
    }
    
    public func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard authResult != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
