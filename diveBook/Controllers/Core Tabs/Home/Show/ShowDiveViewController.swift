//
//  ShowDiveViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 28/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ShowDiveViewController: UIViewController {
    
    var dives: [DiveInfoStruct] = []
    let uid = Auth.auth().currentUser!.uid
    
    var locationLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        dives = fetchData()
        view.backgroundColor = .white
        
        view.addSubview(locationTextView)
        setUpLayout()
    }
    
    let locationTextView: UITextView = {
        let locationTextView = UITextView()
        locationTextView.text = myIndex.location
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        return locationTextView
    }()
    
    private func setUpLayout() {
        locationTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        locationTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        locationTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        locationTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }

    
}

extension ShowDiveViewController {
    
    func fetchData() -> [DiveInfoStruct] {
        
        Firestore.firestore().collection("users").document(uid).collection("DivesCollection").addSnapshotListener { (snapshot, err) in
            
            self.dives = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    
                    let location = data["Location"] as? String ?? "No Location"
                    let diveNr = data["DiveNr"] as? Int ?? 0
                    let date = data["Date"] as? String ?? ""
                    print(location)
                    
                    let newDive = DiveInfoStruct(location: location, diveNr: diveNr, date: date)
                    
                    self.dives.append(newDive)
                    
                }
                
            }
        }
        return dives
    }
}
