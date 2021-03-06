//
//  SimpleItemViewControllerTwo.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 25/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import Foundation
import UIKit

class SimpleItemViewControllerTwo: UIViewController{
    
     private let label = UILabel()
     let backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.11, alpha: 1.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        // view
        view.backgroundColor = backgroundColor
        view.addSubview(label)
        
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.text = "Second Controller"
    }
    
}
