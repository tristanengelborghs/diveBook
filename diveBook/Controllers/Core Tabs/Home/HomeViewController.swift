//
//  ViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 23/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    private let slidingTabController = UISimpleSlidingTabController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI(){
        // view
        view.backgroundColor = .white
        view.addSubview(slidingTabController.view) // add slidingTabController to main view
        
        // navigation
        navigationItem.title = "Dive Log"
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        
        // MARK: slidingTabController
        slidingTabController.addItem(item: SimpleItemViewControllerOne(), title: "Dive Log") // add first item
        slidingTabController.addItem(item: SimpleItemViewControllerTwo(), title: "My Locations")
        // add second item
        slidingTabController.setHeaderActiveColor(color: .blue) // default blue
        slidingTabController.setHeaderInActiveColor(color: .darkGray) // default gray
        slidingTabController.setHeaderBackgroundColor(color: .white) // default white
        slidingTabController.setCurrentPosition(position: 0) // default 0
        //slidingTabController.setStyle(style: .flexible) // default fixed
        slidingTabController.build() // build
        
    }
    
    
    
}



