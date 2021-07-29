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
import CoreLocation

class FetchData {
    
    static let sharedInstance = FetchData()
    let uid = Auth.auth().currentUser!.uid
    
    func fetchCardData(callback: @escaping(CardInfoStruct) -> Void) {
        
        var cardInfo: CardInfoStruct = CardInfoStruct(Name: "", ID: "", Organistation: "", Date: "", DiveClub: "", Instructor: "", Primary: false, PhotoBack: nil)

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
                    let ID = data["ID"] as? String ?? ""
                    let DiveClub = data["DiveClub"] as? String ?? ""
                    let Instructor = data["Instructor"] as? String ?? ""
                    let PhotoBack = data["PhotoBack"] as? Data ?? nil

                    cardInfo = CardInfoStruct(Name: Name, ID: ID, Organistation: Organistation, Date: Date, DiveClub: DiveClub, Instructor: Instructor, Primary: false, PhotoBack: PhotoBack)
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
                    let ID = data["ID"] as? String ?? ""
                    let DiveClub = data["DiveClub"] as? String ?? ""
                    let Instructor = data["Instructor"] as? String ?? ""
                    let Primary = data["Primary"] as? Bool ?? false
                    let PhotoBack = data["PhotoBack"] as? Data ?? nil

                    let cardInfo = CardInfoStruct(Name: Name, ID: ID, Organistation: Organistation, Date: Date, DiveClub: DiveClub, Instructor: Instructor, Primary: Primary,  PhotoBack: PhotoBack)
                    
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
                    
                    let location = data["Location"] as? String ?? ""
                    let divePoint = data["DivePoint"] as? String ?? ""
                    let diveNr = data["DiveNr"] as? Int ?? 0
                    let date = data["Date"] as? String ?? ""
                    let diveTime = data["DiveTime"] as? String ?? ""
                    let startTime = data["TimeIn"] as? String ?? ""
                    let depth = data["MaxDepth"] as? String ?? ""
                    print(location)
                    
                    let newDive = DiveInfoStruct(location: location, divePoint: divePoint, diveNr: diveNr, date: date, diveTime: diveTime, startTime: startTime, depth: depth)
                    
                    dives.append(newDive)
                    
                }
            }
            callback(dives)
        }
    }
    
    func fetchDiveNr(callback: @escaping(Int) -> Void) {
        
        Firestore.firestore().collection("users").document(uid).collection("DivesCollection")
            .order(by: "DiveNr", descending: true).limit(to: 1).addSnapshotListener() { (querySnapshot, err) in
                
                var diveNr: Int = 0
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        
                        diveNr = data["DiveNr"] as? Int ?? 0
                        
                    }
                }
                callback(diveNr)
            }
    }
    
    func fetchEquipment(callback: @escaping([EquipmentStruct]) -> Void) {

        Firestore.firestore().collection("users").document(uid).collection("Settings").document("Equipment").collection("Templates").addSnapshotListener { (snapshot, err) in

            var equipmentArray: [EquipmentStruct] = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()

                    let Name = data["Name"] as? String ?? "Hello"
                    let SuitType = data["SuitType"] as? String ?? ""
                    let SuitThickness = data["SuitThickness"] as? String ?? ""
                    let OneLayer = data["OneLayer"] as? Bool ?? true
                    let TwoLayers = data["TwoLayers"] as? Bool ?? false
                    let Weight = data["Weight"] as? String ?? ""
                    let Extra = data["Extra"] as? [String] ?? []

                    let equipmentInfo = EquipmentStruct(Name: Name, SuitType: SuitType, SuitThickness: SuitThickness, OneLayer: OneLayer, TwoLayers: TwoLayers, Weight: Weight, Extra: Extra)
                    
                    equipmentArray.append(equipmentInfo)
                }
            }
            callback(equipmentArray)
        }
    }
    
    func fetchBuddys(callback: @escaping([BuddyStruct]) -> Void) {

        Firestore.firestore().collection("users").document(uid).collection("Settings").document("Buddys").collection("BuddyCollection").addSnapshotListener { (snapshot, err) in

            var buddyArray: [BuddyStruct] = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()

                    let Name = data["Name"] as? String ?? ""
                    let LastName = data["LastName"] as? String ?? ""
                    let Cirtification = data["Cirtification"] as? String ?? ""
                    let Signature = data["Signature"] as? Data ?? Data.init()

                    let buddyInfo = BuddyStruct(Name: Name, LastName: LastName, Cirtification: Cirtification, signatureData: Signature)
                    
                    buddyArray.append(buddyInfo)
                }
            }
            callback(buddyArray)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation], callback: @escaping([diveSite]) -> Void) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            let userLatitude = Float(location.coordinate.latitude)
            let userLongtitude = Float(location.coordinate.longitude)
            
            
        }
    }
    
    func getData(from url: String, callback: @escaping([diveSite]) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            let str = String(decoding: data, as: UTF8.self)
            let resultString = str.replacingOccurrences(of: "�", with: "")
            let resultData = Data(resultString.utf8)
            
            
            
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: resultData)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            
            let pinLocations = Response(request: json.request, sites: json.sites, version: json.version, loc: json.loc, result: json.result)
            
            var diveSites: [diveSite] = []
            
            for (loc) in pinLocations.sites! {
                diveSites.append(diveSite(currents: loc.currents, distance: loc.distance, hazards: loc.hazards, lat: loc.lat, name: loc.name, water: loc.water, marinelife: loc.marinelife, description: loc.description, maxdepth: loc.maxdepth, mindepth: loc.mindepth, predive: loc.predive, id: loc.id, equipment: loc.equipment, lng: loc.lng))
               
            }
            callback(diveSites)
            
        })

        task.resume()
        
    }
}
