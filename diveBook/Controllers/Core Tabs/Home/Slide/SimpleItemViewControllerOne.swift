//
//  SimpleItemViewControllerOne.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 25/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseFirestore

var myIndex = DiveInfoStruct(location: "", diveNr: 0, date: "", diveTime: 0, startTime: "", depth: 0)

class SimpleItemViewControllerOne: UIViewController{
    
    let backgroundColor = UIColor.systemGray6
    var tableView = UITableView()
    let headerCard = UIButton.init()
    let headerLabel = UILabel.init()
    
    let arrowButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
    let primaryLabel = UILabel.init()
    let nameLabel = UILabel.init()
    let IDLabel = UILabel.init()
    let dateLabel = UILabel.init()
    let organistationLabel = UILabel.init()
    
    var dives: [DiveInfoStruct] = []
    var card: CardInfoStruct = CardInfoStruct(Name: "", ID: "", Organistation: "", Date: "", DiveClub: "", Instructor: "", Primary: false, PhotoBack: nil)
    let uid = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //showActivityIndicatory(uiView: self.view)
        FetchData.sharedInstance.fetchData { (Dives) in
            self.dives = Dives
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        FetchData.sharedInstance.fetchCardData(callback: { (cardInfo) in
            self.card = cardInfo
            self.didFetchData(data: cardInfo)
        })
        configureHeader()
        configureTableView()
    }
    
    func configureHeader() {
        let labelHeight = Utilities.requiredHeight(font:"Avenir Next", labelText: "Logged Dives", size: 17.0) + 45
        let headerHeight = (((view.frame.size.width) - 60) * (7/20)) + labelHeight
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHeight))
        
        header.addSubview(headerCard)
        header.addSubview(organistationLabel)
        header.addSubview(nameLabel)
        header.addSubview(dateLabel)
        header.addSubview(headerLabel)
        header.addSubview(IDLabel)
        header.addSubview(arrowButton)
        header.addSubview(primaryLabel)
        
        
        header.backgroundColor = backgroundColor
        tableView.tableHeaderView = header
        
        headerCard.backgroundColor = backgroundColor
        headerCard.layer.cornerRadius = 15
        headerCard.layer.borderWidth = 1
        headerCard.layer.borderColor = UIColor.label.cgColor
        headerCard.translatesAutoresizingMaskIntoConstraints = false
        headerCard.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        headerCard.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
        headerCard.widthAnchor.constraint(equalToConstant: (view.frame.size.width) - 60).isActive = true
        headerCard.heightAnchor.constraint(equalTo: headerCard.widthAnchor, multiplier: 7/20).isActive = true
        headerCard.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        organistationLabel.translatesAutoresizingMaskIntoConstraints = false
        organistationLabel.font = UIFont.init(name: "AvenirNext-medium", size: 14)
        organistationLabel.topAnchor.constraint(equalTo: headerCard.topAnchor, constant: 10).isActive = true
        organistationLabel.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 20).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.init(name: "AvenirNext-medium", size: 14)
        nameLabel.topAnchor.constraint(equalTo: organistationLabel.bottomAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 20).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.init(name: "Avenir Next", size: 14)
        dateLabel.bottomAnchor.constraint(equalTo: IDLabel.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 20).isActive = true
        
        IDLabel.translatesAutoresizingMaskIntoConstraints = false
        IDLabel.font = UIFont.init(name: "Avenir Next", size: 14)
        IDLabel.bottomAnchor.constraint(equalTo: headerCard.bottomAnchor, constant: -10).isActive = true
        IDLabel.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 20).isActive = true
        
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.font = UIFont.init(name: "Avenir Next", size: 13)
        primaryLabel.topAnchor.constraint(equalTo: headerCard.topAnchor, constant: 12).isActive = true
        primaryLabel.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor, constant: -20).isActive = true
        
        headerLabel.text = "Logged Dives"
        headerLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: headerCard.bottomAnchor, constant: 20).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 30).isActive = true
        
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.centerYAnchor.constraint(equalTo: headerCard.centerYAnchor).isActive = true
        arrowButton.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor, constant: -20).isActive = true
        arrowButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        arrowButton.tintColor = .white
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        headerCard.layer.borderColor = UIColor.label.cgColor
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        let vc = ShowCardsViewController()
        self.present(vc, animated: true, completion: nil)
        //show(vc, sender: self)
    }
    
    func didFetchData(data:CardInfoStruct){
        print(card.Name)
        organistationLabel.text = card.Organistation
        nameLabel.text = card.Name
        dateLabel.text = card.Date
        IDLabel.text = "\(card.ID)"
        primaryLabel.text = "Primary"
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = ((view.frame.size.width - 60) * 7/20) + 20
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.pin(to: view)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 170, right: 0)
        tableView.backgroundColor = backgroundColor
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        myIndex = dives[indexPath.row]
        
        let vc = ShowDiveViewController()
        self.present(vc, animated: true, completion: nil)
    }
}

extension SimpleItemViewControllerOne: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        let dive = dives[indexPath.row]
        cell.set(dive: dive)
        cell.backgroundColor = backgroundColor
        return cell
    }
}

protocol MyDelegate{
     func didFetchData(data:CardInfoStruct)
}

    

