//
//  EquipmentViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 20/12/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class EquipmentViewController: UIViewController {
    
    var titles: [String] = ["cold water","warm water","drysuit template"]
    var dataTextfield: [String] = ["20m","10m","12m"]
    
    var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tv.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 200.0
        tv.estimatedSectionHeaderHeight = 0
        tv.estimatedSectionFooterHeight = 0
        tv.showsVerticalScrollIndicator = false
        tv.tableFooterView = UIView()
        tv.alwaysBounceVertical = true
        tv.decelerationRate = .fast
        tv.bounces = false
        return tv
    }()
    
    var selectedCell:IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.view.backgroundColor = .systemGray6
        setupNavBar()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    @objc func saveEquipment(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
        
    @objc func closeVC(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }

    
    func setupNavBar() {
            let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
            navBar.isTranslucent = false
            navBar.barTintColor = UIColor.systemGray5
            navBar.shadowImage = UIImage()
            view.addSubview(navBar)
            
            let navItem = UINavigationItem(title: "Equipment")
            let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveEquipment))
            let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(closeVC))
            saveItem.tintColor = .white
            
            
            navItem.rightBarButtonItem = saveItem
            navItem.leftBarButtonItem = backItem
            navBar.setItems([navItem], animated: false)
        }


}
extension EquipmentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell ?? CustomCell()
        cell.wordLabel.text = titles[indexPath.row]
        
        if selectedCell != indexPath {
                cell.bottomView.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CustomCell {
            
            UIView.animate(withDuration: 0.3) {
            cell.bottomView.isHidden = !cell.bottomView.isHidden
            }
                
            selectedCell = indexPath
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadData()
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
