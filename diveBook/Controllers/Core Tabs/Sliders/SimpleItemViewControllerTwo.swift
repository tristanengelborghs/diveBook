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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        // view
        view.backgroundColor = .white
        view.addSubview(label)
        
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.text = "Second Controller"
    }
    
}
