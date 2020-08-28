//
//  ViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 25/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let label = UILabel()

    @IBOutlet weak var test: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        test.text = "hello there"
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    private func setupUI(){
        // view
        view.backgroundColor = .white
        view.addSubview(label)
        
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.text = "Third Controller"
    }

}
