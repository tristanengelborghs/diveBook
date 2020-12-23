//
//  AddCardViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 01/11/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

var waterConditionsArray = waterConditionsStruct(type: "", maxTemp: "", minTemp: "", waves: "", visibility: "0m", current: "")
var saveEquipmentArray = EquipmentStruct(Name: "", SuitType: "", SuitThickness: "", OneLayer: true, TwoLayers: false, Weight: "", Extra: [])
var selectedCell: IndexPath?
var selectedCellButton: IndexPath?

class NormalDiveViewController: UIViewController {
    
    let currentDateTime = Date()
    let formatter = DateFormatter()
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    let topGradientView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 340))
    let contentView = UIView()
    
    // first section textfields
    let diveNr = UITextField()
    let location = UITextField()
    let divePoint = UITextField()
    let datePicker: UIDatePicker = UIDatePicker()
    let datePicker2: UIDatePicker = UIDatePicker()
    let dateTextField = UITextField()
    let timeDateTitle = UILabel()
    var timeDateText = ""
    let maxDepth = UITextField()
    let maxDepthTitle = UILabel()
    let avgDepth = UITextField()
    let avgDepthTitle = UILabel()
    let diveIn = UITextField()
    let diveInTitle = UILabel()
    var diveTime = UITextField()
    let diveTimeTitle = UILabel()
    let ratingTitle = UILabel()
    let ratingValue = UILabel()
    let safetyStopTitle = UILabel()
    let safetyStop = UITextField()
    let tankVolumeTitle = UILabel()
    let tankVolume = UISlider()
    let tankVolumeValue = UILabel()
    let tankSteelLabel = UILabel()
    let tankAlLabel = UILabel()
    let tankSteelButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
    let tankAlButton = UIButton()
    let rating = UISlider(frame:CGRect(x: 10, y: 100, width: 300, height: 20))
    let step : Float = 1
    
    // Second section
    let coloredTankBackground = UIView()
    let bottlePhoto = UIImageView()
    let airInTitle = UILabel()
    let barLabel = UILabel()
    let airIn = UITextField()
    let SACTitle = UILabel()
    let barLabel2 = UILabel()
    let SAC = UITextField()
    let airOutTitle = UILabel()
    let barLabel3 = UILabel()
    let airOut = UITextField()
    let nitroxTitle = UILabel()
    let barLabel4 = UILabel()
    let nitrox = UITextField()
    
    //third section
    let conditionsTitle = UILabel()
    let conditions = UIButton()
    let completion = UIButton(type: UIButton.ButtonType.custom) as UIButton
    let entryTitle = UILabel()
    let entry = UITextField()
    let entryArray = ["Select water entry", "Boat", "Shore"]
    var picker = UIPickerView()
    var entryText: String = ""
    let airTempTitle = UILabel()
    let airTemp = UITextField()
    let equipmentTitle = UILabel()
    let equipment = UIButton()
    let completion2 = UIButton(type: UIButton.ButtonType.custom) as UIButton
    
    let SelectedDot = UIImage(named: "SelectedDot") as UIImage?
    let UnselectedDot = UIImage(named: "UnselectedDot") as UIImage?
    let topColor = UIColor(red: 0.07, green: 0.52, blue: 0.63, alpha: 1.00)
    let bottomColor = UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00)
    var colors: [UIColor] = [UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00), UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00)]
    var startPoint = CGPoint.zero
    var endPoint = CGPoint(x: 1, y: 1)
    let label = UILabel()
    private var cornerRadius: CGFloat = 0
    private var borderWidth: CGFloat = 0
    private var gradientLayer = CAGradientLayer()
    private var backgroundView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        self.view.backgroundColor = .systemGray6
        
        setupNavbar()
        setupScrollView()
        topContainer()
        middleTexFields()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //colorView.setGradientBackground(colorTop: topColor, colorBottom: bottomColor)
    }
    
    func setupScrollView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 2000).isActive = true
        label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30).isActive = true
        label.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30).isActive = true
        label.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -30).isActive = true

        label.text = "hello"
        label.tintColor = .white
    }
    
    // navigation bar
    func setupNavbar() {
        
        let navbar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 85))
        view.addSubview(navbar)
        navbar.translatesAutoresizingMaskIntoConstraints = false
        navbar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navbar.heightAnchor.constraint(equalToConstant: 85).isActive = true
        navbar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navbar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        let gradient = CAGradientLayer()
        gradient.frame = navbar.bounds
        gradient.colors = [bottomColor.cgColor, topColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.locations = [0, 1]
        navbar.layer.insertSublayer(gradient, at: 0)
        
        let arrowButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        navbar.addSubview(arrowButton)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        arrowButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 47).isActive = true
        arrowButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        arrowButton.tintColor = .white
        
        let saveButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        navbar.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        saveButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        saveButton.setTitle("Save", for: .normal)
        saveButton.tintColor = .white
        saveButton.addTarget(self, action: #selector(saveButtonActions), for: .touchUpInside)
        navbar.addSubview(diveNr)
        
        diveNr.translatesAutoresizingMaskIntoConstraints = false
        diveNr.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 44).isActive = true
        diveNr.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        diveNr.widthAnchor.constraint(equalToConstant: 100).isActive = true
        diveNr.font = UIFont.init(name: "Avenir Light", size: 22)
        diveNr.textAlignment = .center
        diveNr.alpha = 0.75
        diveNr.attributedPlaceholder = NSAttributedString(string: "143",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func topContainer() {
        let statusBarHeight = Utilities.getStatusBarHeight()
        scrollView.addSubview(topGradientView)
        scrollView.addSubview(location)
        scrollView.addSubview(divePoint)
        
        // top gradient view
        topGradientView.translatesAutoresizingMaskIntoConstraints = false
        topGradientView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -200 + 85 - statusBarHeight ).isActive = true
        topGradientView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        topGradientView.heightAnchor.constraint(equalToConstant: 340).isActive = true
        topGradientView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        let gradient = CAGradientLayer()
        gradient.frame = topGradientView.bounds
        gradient.colors = [bottomColor.cgColor, topColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        topGradientView.layer.insertSublayer(gradient, at: 0)
        
        // location textfield
        location.translatesAutoresizingMaskIntoConstraints = false
        location.bottomAnchor.constraint(equalTo: divePoint.topAnchor, constant: -20).isActive = true
        location.leadingAnchor.constraint(equalTo: topGradientView.leadingAnchor, constant: 45).isActive = true
        location.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        location.heightAnchor.constraint(equalToConstant: 40).isActive = true
        location.font = UIFont.init(name: "Avenir Next", size: 16)
        location.setBottomBorderText(withColor: UIColor.white)
        location.attributedPlaceholder = NSAttributedString(string: "Location",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // name of dive point textfield
        divePoint.translatesAutoresizingMaskIntoConstraints = false
        divePoint.bottomAnchor.constraint(equalTo: topGradientView.bottomAnchor, constant: -40).isActive = true
        divePoint.leadingAnchor.constraint(equalTo: topGradientView.leadingAnchor, constant: 45).isActive = true
        divePoint.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        divePoint.heightAnchor.constraint(equalToConstant: 40).isActive = true
        divePoint.font = UIFont.init(name: "Avenir Next", size: 16)
        divePoint.setBottomBorderText(withColor: UIColor.white)
        divePoint.attributedPlaceholder = NSAttributedString(string: "Dive Point",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // set shadow of blue top view
        topGradientView.layer.shadowColor = UIColor.black.cgColor
        topGradientView.layer.shadowOpacity = 0.7
        topGradientView.layer.shadowOffset = .zero
        topGradientView.layer.shadowRadius = 20

    }
    
    @objc func saveButtonActions() {
        print("\(waterConditionsArray)")
        print("hello")
    }
}

