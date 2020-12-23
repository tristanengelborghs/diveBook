//
//  EquipmentViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 20/12/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class EquipmentViewController: UIViewController, DailySpeakingLessonDelegate {
    
    var currentScrollPos : CGFloat?
    var cellHeights = [IndexPath: CGFloat]()
    var titles: [String] = ["cold water","warm water", "cold water","warm water", "cold water"]
    var dataTextfield: [String] = ["20m","10m","12m", "13m"]
    
    var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tv.allowsSelection = true
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 400
        tv.showsVerticalScrollIndicator = false
        tv.tableFooterView = UIView()
        tv.alwaysBounceVertical = true
        tv.decelerationRate = .fast
        tv.bounces = false
        return tv
    }()
    
    var selectedCell:IndexPath?
    var selectedCellButton:IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.view.backgroundColor = .systemGray6
        setupNavBar()
        setupTableView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.view.setNeedsLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
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
            
            let navItem = UINavigationItem(title: "Select your equipment")
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
        cell.delegate = self
        
        
        if selectedCell != indexPath {
            cell.bottomView.isHidden = true
            cell.editbutton.setTitle("edit", for: .normal)
            cell.checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        } else if selectedCell == nil {
            cell.bottomView.isHidden = true
            cell.editbutton.setTitle("edit", for: .normal)
        } else {
            cell.bottomView.isHidden = !cell.bottomView.isHidden
            if cell.bottomView.isHidden == true {
                cell.editbutton.setTitle("edit", for: .normal)
            } else {
                cell.editbutton.setTitle("close", for: .normal)
            }
            
            cell.checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        
        if selectedCellButton != indexPath {
            cell.checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            cell.bottomView.isHidden = true
            cell.editbutton.setTitle("edit", for: .normal)
        } else {
            cell.checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellButton = indexPath
        selectedCell = nil
        tableView.reloadData()
    }
    
    func reload(indexPatch: UIButton) {
        let buttonPosition = indexPatch.convert(CGPoint(), to:tableView)
        let indexPath = tableView.indexPathForRow(at:buttonPosition)
        selectedCell = indexPath
        selectedCellButton = indexPath
        tableView.reloadData()
    }
    
    func checkboxReload(indexPatch: UIButton) {
        let buttonPosition = indexPatch.convert(CGPoint(), to:tableView)
        let indexPath = tableView.indexPathForRow(at:buttonPosition)
        selectedCellButton = indexPath
        selectedCell = nil
        //let cell = tableView.cellForRow(at: indexPath!) as! CustomCell
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

protocol DailySpeakingLessonDelegate: class {
    func reload(indexPatch: UIButton)
    func checkboxReload(indexPatch: UIButton)
}
