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
    
    private var cornerRadius: CGFloat = 0
    
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
    
    static func requiredHeight(font:String, labelText:String, size:CGFloat) -> CGFloat {

        let font = UIFont(name: font, size: size)
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: .max))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = labelText
        label.sizeToFit()
        return label.frame.height

    }
    
    static func styleFilledButtongradient(_ button:UIButton) {

        let gradientLayer = CAGradientLayer()
        button.layer.cornerRadius = button.frame.size.height/2
        button.layer.masksToBounds = true
        gradientLayer.frame = button.bounds
        gradientLayer.colors = [UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00).cgColor,UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00).cgColor ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    static func styleHollowButtongradient(_ button:UIButton) {
        button.layer.cornerRadius = 25.0
        button.clipsToBounds = true
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = CGRect(origin: .zero, size: button.frame.size)
        gradient.colors = [UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00).cgColor,UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00).cgColor ]
        button.layer.insertSublayer(gradient, at: 0)
        let backgroundView = UIView()
        button.insertSubview(backgroundView, at: 1)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.systemGray6
        backgroundView.fill(toView: button, space: UIEdgeInsets(space: 2))
        backgroundView.layer.cornerRadius = 25
        backgroundView.createRoundCorner(25)
        backgroundView.createRoundCorner(25 - 2)
        backgroundView.isUserInteractionEnabled = false
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
    
    func setBottomBorderText(withColor color: UIColor)
    {
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear
        let width: CGFloat = 1.0

        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width))
        borderLine.backgroundColor = color
        borderLine.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        borderLine.alpha = 0.3
        self.addSubview(borderLine)
    }
    func setDarkTextField(textfield: UITextField) {
        textfield.layer.cornerRadius = 5
        textfield.backgroundColor = .systemGray5
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftView = paddingView
        textfield.leftViewMode = UITextField.ViewMode.always
    }
}

extension UILabel {
    
}

extension UIButton
{
    
}


