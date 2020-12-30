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
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 50
        tv.showsVerticalScrollIndicator = false
        tv.tableFooterView = UIView()
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
                presenter.buddy.setTitleColor(.white, for: .normal)
                presenter.buddy.setTitle("completed", for: .normal)
                presenter.completion3.isHidden = false
            } else {
                presenter.buddy.setTitleColor(.gray, for: .normal)
                presenter.buddy.setTitle("Select here...", for: .normal)
                presenter.completion3.isHidden = true
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
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

protocol buddyDelegate: class {
    func checkboxReload(indexPatch: UIButton)
}



