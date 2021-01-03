//
//  BuddyViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 29/12/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class BuddyViewController: UIViewController, buddyDelegate {

    var currentScrollPos : CGFloat?
    var cellHeights = [IndexPath: CGFloat]()
    var buddyArray: [BuddyStruct] = []
    var selectedBuddyArray: [BuddyStruct] = buddys
    var selectedBuddy: IndexPath?
    var firstTime: Bool = true
    
    var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.register(BuddyTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tv.allowsSelection = true
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = 50
        tv.estimatedRowHeight = 50
        tv.showsVerticalScrollIndicator = false
        tv.alwaysBounceVertical = true
        tv.decelerationRate = .fast
        tv.bounces = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        FetchData.sharedInstance.fetchBuddys(callback: { (buddys) in
            self.buddyArray = buddys
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
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
        tableView.anchorTableView(top: self.view.topAnchor, leading: self.view.layoutMarginsGuide.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.layoutMarginsGuide.trailingAnchor, padding: .init(top: 80, left: 20, bottom: 0, right: 20))
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        customView.backgroundColor = .systemGray6
        let button = UIButton()
        customView.addSubview(button)
        button.layer.borderWidth = 0
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.titleLabel?.font = UIFont.init(name: "Avenir Next Ultra Light", size: 35)
        button.anchorButton(top: customView.topAnchor, leading: customView.leadingAnchor, bottom: customView.bottomAnchor, trailing: customView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        button.setTitle("+", for: .normal)
        button.titleLabel?.textAlignment = .center
        let line = UIView()
        customView.addSubview(line)
        line.anchor(top: customView.topAnchor, leading: customView.leadingAnchor, bottom: nil, trailing: customView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        line.backgroundColor = .systemGray5
        let line2 = UIView()
        customView.addSubview(line2)
        line2.anchor(top: nil, leading: customView.leadingAnchor, bottom: customView.bottomAnchor, trailing: customView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        line2.backgroundColor = .systemGray5
        

        //Add that view in Table Footer View.
        tableView.tableFooterView = customView
    }
        
    @objc func closeVC(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
        selectedCell = nil
        selectedCellButton = nil
    }

    @objc func saveBuddys(sender: UIButton!) {
        if let presenter = presentingViewController as? NormalDiveViewController {

            buddys = Array(Set(selectedBuddyArray))
        
            if Array(Set(selectedBuddyArray)) != [] {
                presenter.buddy.setTitleColor(.gray, for: .normal)
                presenter.buddy.setTitle("Add more", for: .normal)
                presenter.completion3.isHidden = true
                presenter.tableView.anchorTableView2(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 0, height: 0), what: true)
                presenter.myConstraint.isActive = false
                presenter.view.layoutIfNeeded()
                presenter.tableView.reloadData()
            } else {
                presenter.buddy.setTitleColor(.gray, for: .normal)
                presenter.buddy.setTitle("Select here...", for: .normal)
                presenter.completion3.isHidden = true
                presenter.tableView.reloadData()
            }
            
            print(Array(Set(selectedBuddyArray)))
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func setupNavBar() {
            let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
            navBar.isTranslucent = false
            navBar.barTintColor = UIColor.systemGray5
            navBar.shadowImage = UIImage()
            view.addSubview(navBar)
            
            let navItem = UINavigationItem(title: "Select your buddy's")
            let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveBuddys))
            let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(closeVC))
            saveItem.tintColor = .white
            
            
            navItem.rightBarButtonItem = saveItem
            navItem.leftBarButtonItem = backItem
            navBar.setItems([navItem], animated: false)
    }
}
extension BuddyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buddyArray.count == 0 {
                self.tableView.setEmptyMessage("You can add buddy's here or in the settings menu")
            } else {
                self.tableView.restore()
        }
        return buddyArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? BuddyTableViewCell ?? BuddyTableViewCell()
        cell.wordLabel.text = "\(buddyArray[indexPath.row].Name)" + " \(buddyArray[indexPath.row].LastName)"
        
        if firstTime {
            if  buddys.contains(BuddyStruct(Name: "\(buddyArray[indexPath.row].Name)", LastName: "\(buddyArray[indexPath.row].LastName)", Cirtification: "\(buddyArray[indexPath.row].Cirtification)")) {
                cell.checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            }
        }
        
        if selectedBuddy == indexPath {
            if cell.checkButton.currentBackgroundImage == UIImage(systemName: "checkmark.circle.fill") {
                cell.checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
                if let index:Int = self.selectedBuddyArray.firstIndex(where: {$0.Name == "\(buddyArray[indexPath.row].Name)" && $0.LastName == "\(buddyArray[indexPath.row].LastName)" && $0.Cirtification == "\(buddyArray[indexPath.row].Cirtification)"}) {
                    self.selectedBuddyArray.remove(at: index)
                }
            } else {
                cell.checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                let info = BuddyStruct(Name: "\(buddyArray[indexPath.row].Name)", LastName: "\(buddyArray[indexPath.row].LastName)", Cirtification: "\(buddyArray[indexPath.row].Cirtification)")
                selectedBuddyArray.append(info)
            }
        }
        
        print(Array(Set(selectedBuddyArray)))
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        firstTime = false
        selectedBuddy = indexPath
        tableView.reloadData()
    }
    
    func checkboxReload(indexPatch: UIButton) {
        let buttonPosition = indexPatch.convert(CGPoint(), to:tableView)
        let indexPath = tableView.indexPathForRow(at:buttonPosition)
        selectedBuddy = indexPath
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

protocol buddyDelegate: class {
    func checkboxReload(indexPatch: UIButton)
}

extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}



