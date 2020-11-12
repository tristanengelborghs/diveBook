//
//  CirtifiedDiveViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 28/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class CirtifiedDiveViewController: UIViewController {
    
    let uid = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        
    }

    
//    @IBAction func AddDiveTapped(_ sender: UIButton) {
//
//        let Location = LocationTextField.text ?? "No Location"
//        let DiveNr = Int(DiveNrTextField.text ?? "") ?? 0
//        let Date = DateTextField.text ?? "No Date"
//
//        Firestore.firestore().collection("users").document(uid).collection("DivesCollection").document("\(DiveNr)").setData([
//            "Location": Location,
//            "DiveNr": DiveNr,
//            "Date": Date
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//        self.dismiss(animated: true, completion: nil)
//
//    }
    
}
