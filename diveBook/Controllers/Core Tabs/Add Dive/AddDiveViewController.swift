//
//  AddDiveViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 23/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class AddDiveViewController: UIViewController {
    
    let certifiedButton = UIButton()
    let uncertifiedButton = UIButton()
    let technicalButton = UIButton()
    let divesNrLabel = UILabel()
    let divesLabel = UILabel()
    let descriptionLablel = UILabel()
    let lineView = UIView()
    let shark = UIImageView()
    
    var dives: [DiveInfoStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        FetchData.sharedInstance.fetchDiveNr { (diveNr) in
            let diveNr = diveNr
            self.divesNrLabel.text = "\(diveNr + 1)"
        }
        setupLayout()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Utilities.styleFilledButtongradient(uncertifiedButton)
        Utilities.styleHollowButtongradient(certifiedButton)
        Utilities.styleFilledButtongradient(technicalButton)
    }
    
    func setupLayout() {
        view.addSubview(shark)
        view.addSubview(technicalButton)
        view.addSubview(certifiedButton)
        view.addSubview(uncertifiedButton)
        view.addSubview(divesLabel)
        view.addSubview(divesNrLabel)
        view.addSubview(descriptionLablel)
        view.addSubview(lineView)
        
        let height = tabBarController?.tabBar.frame.size.height
        
        shark.translatesAutoresizingMaskIntoConstraints = false
        shark.translatesAutoresizingMaskIntoConstraints = false
        
        shark.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        shark.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        shark.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        shark.bottomAnchor.constraint(equalTo: descriptionLablel.topAnchor, constant: -20).isActive = true
        shark.clipsToBounds = true
        shark.image =  UIImage(named:"Shark")!
        shark.alpha = 0.4
        
        
        technicalButton.translatesAutoresizingMaskIntoConstraints = false
        technicalButton.setTitleColor(.white, for: .normal)
        technicalButton.translatesAutoresizingMaskIntoConstraints = false
        technicalButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        technicalButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -height! - 30).isActive = true
        technicalButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        technicalButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        technicalButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        technicalButton.setTitle("Certified Dive", for: .normal)
        technicalButton.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 16)
        technicalButton.addTarget(self, action: #selector(uncertifiedPressed), for: .touchUpInside)

        
        uncertifiedButton.translatesAutoresizingMaskIntoConstraints = false
        uncertifiedButton.setTitleColor(.white, for: .normal)
        uncertifiedButton.translatesAutoresizingMaskIntoConstraints = false
        uncertifiedButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        uncertifiedButton.bottomAnchor.constraint(equalTo: technicalButton.topAnchor, constant: -20).isActive = true
        uncertifiedButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        uncertifiedButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        uncertifiedButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uncertifiedButton.setTitle("Quick Log", for: .normal)
        uncertifiedButton.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 16)
        uncertifiedButton.addTarget(self, action: #selector(uncertifiedPressed), for: .touchUpInside)
        
        certifiedButton.translatesAutoresizingMaskIntoConstraints = false
        certifiedButton.backgroundColor = .systemGray6
        certifiedButton.setTitleColor(.white, for: .normal)
        certifiedButton.translatesAutoresizingMaskIntoConstraints = false
        certifiedButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        certifiedButton.bottomAnchor.constraint(equalTo: uncertifiedButton.topAnchor, constant: -20).isActive = true
        certifiedButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        certifiedButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        certifiedButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        certifiedButton.setTitle("Technical Dive", for: .normal)
        certifiedButton.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 16)
        certifiedButton.addTarget(self, action: #selector(certifiedPressed), for: .touchUpInside)
 
        divesLabel.translatesAutoresizingMaskIntoConstraints = false
        divesLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        divesLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        divesLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        divesLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        divesLabel.font = UIFont.init(name: "Avenir Next", size: 18)
        divesLabel.textAlignment = .center
        divesLabel.text = "Next dive"
        
        divesNrLabel.translatesAutoresizingMaskIntoConstraints = false
        divesNrLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        divesNrLabel.topAnchor.constraint(equalTo: divesLabel.bottomAnchor, constant: 10).isActive = true
        divesNrLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        divesNrLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        divesNrLabel.font = UIFont(name: "Avenir Next Ultra Light", size: 100)
        divesNrLabel.textAlignment = .center
        divesNrLabel.textColor = UIColor(red: 0.07, green: 0.63, blue: 0.80, alpha: 1)
        
        descriptionLablel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLablel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        descriptionLablel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        descriptionLablel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        descriptionLablel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        descriptionLablel.font = UIFont(name: "Avenir Next", size: 16)
        descriptionLablel.numberOfLines = 0
        descriptionLablel.textAlignment = .center
        descriptionLablel.text = "You can certified your dive by adding your buddy's id number"
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: descriptionLablel.bottomAnchor, constant: 10).isActive = true
        lineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.backgroundColor = UIColor.systemGray6
        
    }
    
    @objc func uncertifiedPressed(sender: UIButton!){
        let vc = NormalDiveViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func certifiedPressed(){
        let vc = CirtifiedDiveViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

