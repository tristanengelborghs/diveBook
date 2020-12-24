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
    var equipmentArray: [EquipmentStruct] = []
    var titles: [String] = ["Cold water","Zilvermeer","Gozo","Drysuit cold","Drysuit warm"]
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

    override func viewDidLoad() {
        super.viewDidLoad()
        FetchData.sharedInstance.fetchEquipment(callback: { (equipment) in
            self.equipmentArray = equipment
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

    @objc func saveEquipment(sender: UIButton!) {
        if let presenter = presentingViewController as? NormalDiveViewController {
            let cell = tableView.cellForRow(at: selectedCellButton!) as! CustomCell
            print(cell.suitType.text!)
            var layerBool: Bool?
            var commonExtras: [String] = []
            if cell.oneLayerButton.currentBackgroundImage == UIImage(systemName: "circle") {
                layerBool = false
            } else {
                layerBool = true
            }
            
            for button in cell.common {
                if (button.titleLabel?.alpha == 1) {
                    let title = button.titleLabel?.text
                    commonExtras.append(title!)
                }
            }
            
            let name: String = "\(cell.wordLabel.text ?? "")"
            let suitType: String = "\(cell.suitType.text ?? "")"
            let suitThickness: String = "\(cell.suitThick.text ?? "")"
            let oneLayer: Bool = layerBool ?? true
            let twoLayers: Bool = !(layerBool ?? false)
            let weights: String = "\(cell.wheight.text ?? "")"
            let extra: [String] = commonExtras
            
            saveEquipmentArray.Name = name
            saveEquipmentArray.SuitType = suitType
            saveEquipmentArray.SuitThickness = suitThickness
            saveEquipmentArray.OneLayer = oneLayer
            saveEquipmentArray.TwoLayers = twoLayers
            saveEquipmentArray.Weight = weights
            saveEquipmentArray.Extra = extra

            
            if (name != "" || suitType != "" || suitThickness != "" || weights != "" || extra != []) {
                presenter.equipment.setTitleColor(.white, for: .normal)
                presenter.equipment.setTitle("completed", for: .normal)
                presenter.completion2.isHidden = false
            } else {
                presenter.equipment.setTitleColor(.gray, for: .normal)
                presenter.equipment.setTitle("Select here...", for: .normal)
                presenter.completion2.isHidden = true
            }
        }
        print(saveEquipmentArray)
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
        if equipmentArray.count == 0 {
                self.tableView.setEmptyMessage("You can add equipment templates in the settings menu")
            } else {
                self.tableView.restore()
        }
        
        return equipmentArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell ?? CustomCell()
        cell.wordLabel.text = equipmentArray[indexPath.row].Name
        cell.suitType.text = equipmentArray[indexPath.row].SuitType
        cell.suitThick.text = equipmentArray[indexPath.row].SuitThickness
        
        if equipmentArray[indexPath.row].TwoLayers == true {
            cell.oneLayerButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            cell.twoLayerButton.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
        }
        cell.wheight.text = equipmentArray[indexPath.row].Weight
        
        for button in cell.common {
            if equipmentArray[indexPath.row].Extra.contains((button.titleLabel?.text)!) {
                connected(sender: button)
            }
        }
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
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero

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
    
    func connected(sender: UIButton){
        // create gradientlayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "buttonLayer"
        sender.layer.cornerRadius = sender.frame.size.height/2
        sender.layer.masksToBounds = true
        gradientLayer.frame = sender.bounds
        gradientLayer.colors = [UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00).cgColor,UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00).cgColor ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        sender.titleLabel?.alpha = 1
        sender.layer.insertSublayer(gradientLayer, at: 0)
        
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

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
