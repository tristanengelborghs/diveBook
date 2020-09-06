//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func requiredHeight(labelText:String) -> CGFloat {

        let font = UIFont(name: "Avenir NEx", size: 17.0)
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: .max))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = labelText
        label.sizeToFit()
        return label.frame.height

    }
    
}

extension UITextField
{
    func setBottomBorder(withColor color: UIColor)
    {
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear
        let width: CGFloat = 3.0

        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width))
        borderLine.backgroundColor = color
        borderLine.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        self.addSubview(borderLine)
    }
}
