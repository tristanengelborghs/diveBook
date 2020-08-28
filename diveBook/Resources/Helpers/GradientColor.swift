//
//  GradientColor.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 23/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    var gl:CAGradientLayer!

    init() {
        let colorTop = UIColor(red: 0.00, green: 0.67, blue: 0.85, alpha: 1.00).cgColor
        let colorBottom = UIColor(red: 0.07, green: 0.24, blue: 0.65, alpha: 1.00).cgColor

        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}

