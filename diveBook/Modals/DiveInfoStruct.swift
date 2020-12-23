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
    var diveNr: Int
    var date: String
    var diveTime: Int
    var startTime: String
    var depth: Int
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
