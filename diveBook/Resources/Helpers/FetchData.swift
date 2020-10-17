//
//  FetchData.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 04/09/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FetchData {
    
    static let sharedInstance = FetchData()
    let uid = Auth.auth().currentUser!.uid
    
    func fetchCardData(callback: @escaping(CardInfoStruct) -> Void) {
        
        var cardInfo: CardInfoStruct = CardInfoStruct(Name: "", ID: 0, Organistation: "", Date: "", DiveClub: "")

        Firestore.firestore().collection("users").document(uid).collection("Cards").whereField("Primary", isEqualTo: true).addSnapshotListener { (snapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()

                    let Name = data["Name"] as? String ?? "Hello"
                    let Organistation = data["Organisation"] as? String ?? ""
                    let Date = data["Date"] as? String ?? ""
                    let ID = data["ID"] as? Int ?? 0
                    let DiveClub = data["DiveClub"] as? String ?? ""

                    cardInfo = CardInfoStruct(Name: Name, ID: ID, Organistation: Organistation, Date: Date, DiveClub: DiveClub)
                }
            }
            callback(cardInfo)
        }
    }
    
    func fetchCards(callback: @escaping([CardInfoStruct]) -> Void) {

        Firestore.firestore().collection("users").document(uid).collection("Cards").order(by: "Primary", descending: true).addSnapshotListener { (snapshot, err) in

            var cardsInfo: [CardInfoStruct] = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()

                    let Name = data["Name"] as? String ?? "Hello"
                    let Organistation = data["Organisation"] as? String ?? ""
                    let Date = data["Date"] as? String ?? ""
                    let ID = data["ID"] as? Int ?? 0
                    let DiveClub = data["DiveClub"] as? String ?? ""

                    let cardInfo = CardInfoStruct(Name: Name, ID: ID, Organistation: Organistation, Date: Date, DiveClub: DiveClub)
                    
                    cardsInfo.append(cardInfo)
                }
            }
            callback(cardsInfo)
        }
    }
    
    func fetchData(callback: @escaping([DiveInfoStruct]) -> Void) {
        
        Firestore.firestore().collection("users").document(uid).collection("DivesCollection").order(by: "DiveNr", descending: true).addSnapshotListener { (snapshot, err) in
            
            var dives: [DiveInfoStruct] = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    
                    let location = data["Location"] as? String ?? "No Location"
                    let diveNr = data["DiveNr"] as? Int ?? 0
                    let date = data["Date"] as? String ?? ""
                    let diveTime = data["DiveTime"] as? Int ?? 0
                    let startTime = data["StartTime"] as? String ?? ""
                    let depth = data["Depth"] as? Int ?? 0
                    print(location)
                    
                    let newDive = DiveInfoStruct(location: location, diveNr: diveNr, date: date, diveTime: diveTime, startTime: startTime, depth: depth)
                    
                    dives.append(newDive)
                    
                }
            }
            callback(dives)
        }
    }
}
