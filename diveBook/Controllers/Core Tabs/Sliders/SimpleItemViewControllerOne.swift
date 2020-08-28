//
//  SimpleItemViewControllerOne.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 25/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseFirestore


var myIndex = DiveInfoStruct(location: "", diveNr: 0, date: "")

class SimpleItemViewControllerOne: UIViewController{
    
    var tableView = UITableView()
    var dives: [DiveInfoStruct] = []
    let uid = Auth.auth().currentUser!.uid
    
    override func loadView() {
        super.loadView()
        dives = fetchData()
        configureTableView()
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 200
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.pin(to: view)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        myIndex = dives[indexPath.row]
        
        let vc = ShowDiveViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension SimpleItemViewControllerOne: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        let dive = dives[indexPath.row]
        cell.set(dive: dive)
        
        return cell
    }
    
    
}

extension SimpleItemViewControllerOne {
    
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
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            }
        }
        return dives
    }
}
    

