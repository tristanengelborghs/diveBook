//
//  Dives.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 26/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

struct DiveInfoStruct {
    var location: String
    var divePoint: String
    var diveNr: Int
    var date: String
    var diveTime: String
    var startTime: String
    var depth: String
}

struct CardInfoStruct {
    var Name: String
    var ID: String
    var Organistation: String
    var Date: String
    var DiveClub: String
    var Instructor: String
    var Primary: Bool
    var PhotoBack: Data?
}

struct waterConditionsStruct {
    var type: String
    var maxTemp: String
    var minTemp: String
    var waves: String
    var visibility: String
    var current: String
}

struct EquipmentStruct {
    var Name: String
    var SuitType: String
    var SuitThickness: String
    var OneLayer: Bool
    var TwoLayers: Bool
    var Weight: String
    var Extra: [String]
}

struct SignatureStruct {
    var Data: Data
}

struct BuddyStruct : Hashable  {
    var Name: String
    var LastName: String
    var Cirtification: String
    var signatureData: Data
}

extension BuddyStruct: Equatable{}

func ==(lhs: BuddyStruct, rhs: BuddyStruct) -> Bool {
    return lhs.Name == rhs.Name && lhs.LastName == rhs.LastName
}
