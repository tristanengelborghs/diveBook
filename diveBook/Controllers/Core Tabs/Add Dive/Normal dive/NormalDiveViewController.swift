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
var saveEquipmentArray = EquipmentStruct(Name: "", SuitType: "", SuitThickness: "", OneLayer: "true", TwoLayers: "false", Weight: "", Extra: [])
var buddys: [BuddyStruct] = []
var selectedCell: IndexPath?
var selectedCellButton: IndexPath?
var photoDataArray: [Data] = []
var senderButton:UIButton?

class NormalDiveViewController: UIViewController {
    
    let uid = Auth.auth().currentUser!.uid
    
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
    var featuresArray = [UIButton]()
    var purposesArray = [UIButton]()
    let completion2 = UIButton(type: UIButton.ButtonType.custom) as UIButton
    
    let row1 = UIStackView()
    let row2 = UIStackView()
    let row3 = UIStackView()
    let row4 = UIStackView()
    let row5 = UIStackView()
    let line = UIView()
    let line2 = UIView()
    let memo = UITextView()
    let memoTitle = UILabel()
    let features = UILabel()
    let purpose = UILabel()
    
    let CoralReef = UIButton()
    let Wreck = UIButton()
    let Wall = UIButton()
    let Muck = UIButton()
    let Cenote = UIButton()
    let BlueHole = UIButton()
    let Mines = UIButton()
    let Quarry = UIButton()
    let Ocean = UIButton()
    let Ruins = UIButton()
    let Lake = UIButton()
    let Channel = UIButton()
    let Altitude = UIButton()
    let Kelp = UIButton()
    let River = UIButton()
    let Ice = UIButton()
    
    let row6 = UIStackView()
    let row7 = UIStackView()
    let row8 = UIStackView()
    let row9 = UIStackView()
    let row10 = UIStackView()
    
    let FunDive = UIButton()
    let Training = UIButton()
    let Research = UIButton()
    let Technical = UIButton()
    let SearchRescue = UIButton()
    let Drift = UIButton()
    let Night = UIButton()
    let Photography = UIButton()
    let SkilPractice = UIButton()
    let Rebreather = UIButton()
    let Deep = UIButton()
    let ColdWater = UIButton()
    let SideMount = UIButton()
    
    let photogalleryTitle = UILabel()
    let photogallery = UIButton()
    var myCollectionView: UICollectionView?
    var photoBack = Data()
    var photoBackString: Data?
    let photogalleryAction = UIButton()
    
    let buddyTitle = UILabel()
    let buddy = UIButton()
    let completion3 = UIButton(type: UIButton.ButtonType.custom) as UIButton
    let resortTitle = UILabel()
    let resort = UITextField()
    
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
    var myConstraint = NSLayoutConstraint()
    var myConstraint2 = NSLayoutConstraint()
    
    let saveButton = UIButton()
    
    var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.register(BuddyCertificationTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tv.allowsSelection = true
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tv.preservesSuperviewLayoutMargins = false
        tv.separatorInset = UIEdgeInsets.zero
        tv.layoutMargins = UIEdgeInsets.zero
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 50
        tv.showsVerticalScrollIndicator = false
        tv.alwaysBounceVertical = true
        tv.decelerationRate = .fast
        tv.bounces = false
        tv.separatorColor = UIColor.systemGray2
        return tv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        self.view.backgroundColor = .systemGray6
        
        setupNavbar()
        setupScrollView()
        topContainer()
        middleTexFields()
        BottomTexFields()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Utilities.styleFilledButtongradient(saveButton)
    }
    
    func setupScrollView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 3000).isActive = true
        //label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30).isActive = true
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
        diveNr.text = "143"
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
        
        let DiveNr = diveNr.text ?? ""
        let Location = location.text ?? ""
        let DivePoint = divePoint.text ?? ""
        let Date = dateTextField.text ?? ""
        let TimeIn = diveIn.text ?? ""
        let DiveTime = diveTime.text ?? ""
        let MaxDepth = maxDepth.text ?? ""
        let AvgDepth = avgDepth.text ?? ""
        let Rating = ratingValue.text ?? ""
        let SafetyStop = safetyStop.text ?? ""
        let TankVolume = tankVolumeValue.text ?? ""
        var SteelTank: Bool = true
        var AlTank: Bool = true
        if tankSteelButton.currentBackgroundImage == UIImage(systemName: "circle") {
            SteelTank = false
            AlTank = true
        }
        let AirIn = airIn.text ?? ""
        let Sac = SAC.text ?? ""
        let AirOut = airOut.text ?? ""
        let Nitrox = nitrox.text ?? ""
        let WaterConditions = ["Type": waterConditionsArray.type, "MaxTemp": waterConditionsArray.maxTemp, "MinTemp": waterConditionsArray.minTemp, "Waves": waterConditionsArray.waves, "Visibility": waterConditionsArray.visibility, "Current": waterConditionsArray.current] as [String : String]
        
        let Equipment = ["Name": saveEquipmentArray.Name, "SuitType": saveEquipmentArray.SuitType, "SuitThickness": saveEquipmentArray.SuitThickness, "OneLayer": saveEquipmentArray.OneLayer, "TwoLayers": saveEquipmentArray.TwoLayers, "Weight": saveEquipmentArray.Weight, "Extra": saveEquipmentArray.Extra] as [String : String]
        
        let Memo = memo.text ?? ""
        
        var activeFeatures: [String] = []
        for button in featuresArray {
            if (button.titleLabel?.alpha == 1) {
                let title = button.titleLabel?.text
                activeFeatures.append(title!)
            }
        }
        
        var activePurposes: [String] = []
        for button in purposesArray {
            if (button.titleLabel?.alpha == 1) {
                let title = button.titleLabel?.text
                activePurposes.append(title!)
            }
        }
        
        //let Photos = photoDataArray
        let DiveResort = resort.text ?? ""
        let Buddys = buddys
        
        Firestore.firestore().collection("users").document(uid).collection("DivesCollection").document(DiveNr).setData([
            "DiveNr": DiveNr,
            "Location": Location,
            "DivePoint": DivePoint,
            "Date": Date,
            "TimeIn": TimeIn,
            "DiveTime": DiveTime,
            "MaxDepth": MaxDepth,
            "AvgDepth": AvgDepth,
            "Rating": Rating,
            "SafetyStop": SafetyStop,
            "TankVolume": TankVolume,
            "SteelTank": SteelTank,
            "AlTank": AlTank,
            "AirIn": AirIn,
            "SAC": Sac,
            "AirOut": AirOut,
            "Nitrox": Nitrox,
            "WaterConditions": WaterConditions as Any,
            "Equipment": Equipment as Any,
            "Memo": Memo,
            "ActiveFeatures": activeFeatures,
            "ActivePurposes": activePurposes,
            //"Photos": Photos,
            "DiveResort": DiveResort,
            "Buddy's": Buddys
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension String {
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
}

extension Bool {
    var string: String {
        switch self {
        case true:
            return "true"
        case false:
            return "false"
        }
    }
}


