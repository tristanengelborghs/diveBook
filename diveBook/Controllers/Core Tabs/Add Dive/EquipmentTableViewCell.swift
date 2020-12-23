//
//  EquipmentTableViewCell.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 20/12/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    weak var delegate: DailySpeakingLessonDelegate?
    var indexPatch: NSIndexPath = NSIndexPath()

    var suitTypeArray: [String] = ["--","Swim", "Short", "Wet", "Semi-Dry", "Dry"]
    let stackView = UIStackView()
    let topView = UIView()
    let editbutton = UIButton()
    let wordLabel = UILabel()
    let bottomView = UIView()
    let suitTypeTitle = UILabel()
    let suitType = UITextField()
    var suitTypeText = ""
    let suitThickTitle = UILabel()
    let suitThick = UITextField()
    var picker = UIPickerView()
    var picker2 = UIPickerView()
    let oneLayerButton = UIButton()
    let oneLayerLabel = UILabel()
    let twoLayerButton = UIButton()
    let twoLayerLabel = UILabel()
    let SelectedDot = UIImage(named: "SelectedDot") as UIImage?
    let UnselectedDot = UIImage(named: "UnselectedDot") as UIImage?
    let wheightTitle = UILabel()
    let wheight = UITextField()
    
    //multiple choice
    let multipleChoiceView = UILabel()
    let hood = UIButton()
    let hoodVest = UIButton()
    let gloves = UIButton()
    let dryGloves = UIButton()
    let buoy = UIButton()
    let torch = UIButton()
    let reefHook = UIButton()
    let compass = UIButton()
    let reel = UIButton()
    let knife = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabels()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setupLabels() {

        // configure stack view
        selectionStyle = .none
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)

        // configure top view
        topView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(topView)
        topView.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 30).isActive = true
        wordLabel.text = ""
        wordLabel.numberOfLines = 0
        wordLabel.lineBreakMode = .byWordWrapping
        
        stackView.addSubview(editbutton)
        editbutton.translatesAutoresizingMaskIntoConstraints = false
        editbutton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0).isActive = true
        editbutton.leadingAnchor.constraint(equalTo: wordLabel.trailingAnchor, constant: 20).isActive = true
        editbutton.trailingAnchor.constraint(equalTo: editbutton.trailingAnchor, constant: 0).isActive = true
        createEquipment(button: editbutton, name: "Hood")
        editbutton.addTarget(self, action: #selector(connected), for: .touchUpInside)
        editbutton.addTarget(self, action: #selector(toggleView), for: .touchUpInside)
        
        // configure bottom view
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(bottomView)
        bottomView.addSubview(suitTypeTitle)
        bottomView.addSubview(suitType)
        bottomView.addSubview(suitThickTitle)
        bottomView.addSubview(suitThick)
        bottomView.addSubview(oneLayerLabel)
        bottomView.addSubview(oneLayerButton)
        bottomView.addSubview(twoLayerButton)
        bottomView.addSubview(twoLayerLabel)
        bottomView.addSubview(wheightTitle)
        bottomView.addSubview(wheight)
        bottomView.isHidden = true

        // suit type title
        suitTypeTitle.translatesAutoresizingMaskIntoConstraints = false
        suitTypeTitle.text = "Suit type"
        suitTypeTitle.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20).isActive = true
        suitTypeTitle.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -30).isActive = true
        suitTypeTitle.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 30).isActive = true
        suitTypeTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        suitTypeTitle.alpha = 0.75
        
        // suit type textfield
        suitType.setDarkTextField(textfield: suitType)
        suitType.translatesAutoresizingMaskIntoConstraints = false
        suitType.topAnchor.constraint(equalTo: suitTypeTitle.bottomAnchor, constant: 10).isActive = true
        suitType.trailingAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: -10).isActive = true
        suitType.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 30).isActive = true
        suitType.font = UIFont.init(name: "Avenir Next", size: 16)
        setupPicker(textField: suitType, picker: picker)
        suitThick.delegate = self
        suitType.attributedPlaceholder = NSAttributedString(string: "Select here...",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        // suit thickness title
        suitThickTitle.translatesAutoresizingMaskIntoConstraints = false
        suitThickTitle.text = "Thickness"
        suitThickTitle.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20).isActive = true
        suitThickTitle.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -30).isActive = true
        suitThickTitle.leftAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 10).isActive = true
        suitThickTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        suitThickTitle.alpha = 0.75
        
        // suit thickness textfield
        suitThick.setDarkTextField(textfield: suitThick)
        suitThick.translatesAutoresizingMaskIntoConstraints = false
        suitThick.topAnchor.constraint(equalTo: suitThickTitle.bottomAnchor, constant: 10).isActive = true
        suitThick.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -30).isActive = true
        suitThick.leftAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 10).isActive = true
        suitThick.font = UIFont.init(name: "Avenir Next", size: 16)
        suitThick.keyboardType = UIKeyboardType.decimalPad
        suitThick.attributedPlaceholder = NSAttributedString(string: "0mm",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        // One layer button
        oneLayerButton.translatesAutoresizingMaskIntoConstraints = false
        oneLayerButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 30).isActive = true
        oneLayerButton.topAnchor.constraint(equalTo: suitThick.bottomAnchor, constant: 20).isActive = true
        oneLayerButton.frame = CGRect(x: 100, y: 100, width: 130, height: 130)
        oneLayerButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        oneLayerButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        oneLayerButton.setBackgroundImage(SelectedDot, for: .normal)
        oneLayerButton.addTarget(self, action: #selector(oneLayerButtonAction), for: .touchUpInside)
        
        // One layer label
        oneLayerLabel.translatesAutoresizingMaskIntoConstraints = false
        oneLayerLabel.centerYAnchor.constraint(equalTo: oneLayerButton.centerYAnchor, constant: 0).isActive = true
        oneLayerLabel.leadingAnchor.constraint(equalTo: oneLayerButton.trailingAnchor, constant: 15).isActive = true
        oneLayerLabel.text = "One layer"
        oneLayerLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        oneLayerLabel.alpha = 0.75
        
        // Two layers button
        twoLayerButton.translatesAutoresizingMaskIntoConstraints = false
        twoLayerButton.leadingAnchor.constraint(equalTo: oneLayerLabel.trailingAnchor, constant: 30).isActive = true
        twoLayerButton.topAnchor.constraint(equalTo: suitThick.bottomAnchor, constant: 20).isActive = true
        twoLayerButton.frame = CGRect(x: 100, y: 100, width: 130, height: 130)
        twoLayerButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        twoLayerButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        twoLayerButton.setBackgroundImage(UnselectedDot, for: .normal)
        twoLayerButton.addTarget(self, action: #selector(TwoLayerButtonAction), for: .touchUpInside)
        
        // Two layers label
        twoLayerLabel.translatesAutoresizingMaskIntoConstraints = false
        twoLayerLabel.centerYAnchor.constraint(equalTo: twoLayerButton.centerYAnchor, constant: 0).isActive = true
        twoLayerLabel.leadingAnchor.constraint(equalTo: twoLayerButton.trailingAnchor, constant: 15).isActive = true
        twoLayerLabel.text = "Two layers"
        twoLayerLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        twoLayerLabel.alpha = 0.75
        
        // suit thickness title
        wheightTitle.translatesAutoresizingMaskIntoConstraints = false
        wheightTitle.text = "Wheight"
        wheightTitle.topAnchor.constraint(equalTo: oneLayerLabel.bottomAnchor, constant: 10).isActive = true
        wheightTitle.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -30).isActive = true
        wheightTitle.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 30).isActive = true
        wheightTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        wheightTitle.alpha = 0.75
        
        // suit thickness textfield
        wheight.setDarkTextField(textfield: wheight)
        wheight.translatesAutoresizingMaskIntoConstraints = false
        wheight.topAnchor.constraint(equalTo: wheightTitle.bottomAnchor, constant: 10).isActive = true
        wheight.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -30).isActive = true
        wheight.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 30).isActive = true
        wheight.font = UIFont.init(name: "Avenir Next", size: 16)
        wheight.keyboardType = UIKeyboardType.decimalPad
        wheight.delegate = self
        wheight.attributedPlaceholder = NSAttributedString(string: "0 kg",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        multipleChoiceConfigure()
        
        
        
        
        // height anchors
        topView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        bottomView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300).isActive = true
        suitType.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        suitThick.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        oneLayerLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        twoLayerLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        wheight.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        multipleChoiceView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true

        // stackview constraints
        stackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor,constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor,constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor,constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor,constant: 10).isActive = true

    }
    
    func multipleChoiceConfigure() {
        bottomView.addSubview(multipleChoiceView)
        bottomView.addSubview(hood)
        bottomView.addSubview(hoodVest)
        bottomView.addSubview(gloves)
        bottomView.addSubview(dryGloves)
        bottomView.addSubview(buoy)
        bottomView.addSubview(torch)
        bottomView.addSubview(reefHook)
        bottomView.addSubview(compass)
        bottomView.addSubview(reel)
        bottomView.addSubview(knife)
        
        multipleChoiceView.translatesAutoresizingMaskIntoConstraints = false
        multipleChoiceView.topAnchor.constraint(equalTo: wheight.bottomAnchor, constant: 20).isActive = true
        multipleChoiceView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 30).isActive = true
        multipleChoiceView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -30).isActive = true
        multipleChoiceView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0).isActive = true
        
        hood.translatesAutoresizingMaskIntoConstraints = false
        hood.topAnchor.constraint(equalTo: multipleChoiceView.topAnchor, constant: 0).isActive = true
        hood.leadingAnchor.constraint(equalTo: multipleChoiceView.leadingAnchor).isActive = true
        createEquipment(button: hood, name: "Hood")
        hood.addTarget(self, action: #selector(connected), for: .touchUpInside)
        
        hoodVest.translatesAutoresizingMaskIntoConstraints = false
        hoodVest.topAnchor.constraint(equalTo: multipleChoiceView.topAnchor, constant: 0).isActive = true
        hoodVest.centerXAnchor.constraint(equalTo: multipleChoiceView.centerXAnchor).isActive = true
        hoodVest.leadingAnchor.constraint(equalTo: hood.trailingAnchor, constant: 10).isActive = true
        hoodVest.trailingAnchor.constraint(equalTo: gloves.leadingAnchor, constant: -10).isActive = true
        createEquipment(button: hoodVest, name: "Hood vest")
        hoodVest.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20,bottom: 5,right: 20)
        hoodVest.addTarget(self, action: #selector(connected), for: .touchUpInside)
        
        gloves.translatesAutoresizingMaskIntoConstraints = false
        gloves.topAnchor.constraint(equalTo: multipleChoiceView.topAnchor, constant: 0).isActive = true
        gloves.trailingAnchor.constraint(equalTo: multipleChoiceView.trailingAnchor).isActive = true
        createEquipment(button: gloves, name: "Gloves")
        gloves.addTarget(self, action: #selector(connected), for: .touchUpInside)
    }
    
    func createEquipment(button: UIButton, name: String) {
        button.backgroundColor = .systemGray5
        button.createRoundCorner(16)
        button.titleLabel?.font =  UIFont(name: "Avenir Next", size: 16)
        button.titleLabel?.alpha = 0.75
        button.setTitle("\(name)", for: .normal)
        button.titleLabel?.textAlignment = .center
    }
    
    @objc func toggleView(sender: UIButton!) {
            indexPatch = NSIndexPath(row: sender.tag, section: 0)
            delegate?.reload(indexPatch: sender)
    }
    
    @objc func connected(sender: UIButton){
        // create gradientlayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "buttonLayer"
        sender.layer.cornerRadius = sender.frame.size.height/2
        sender.layer.masksToBounds = true
        gradientLayer.frame = sender.bounds
        gradientLayer.colors = [UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00).cgColor,UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00).cgColor ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        if (sender.titleLabel?.alpha == 0.75) {
            sender.titleLabel?.alpha = 1
            sender.layer.insertSublayer(gradientLayer, at: 0)
            super.layoutSubviews()
        } else {
            for layer in sender.layer.sublayers! {
                    if(layer.name == "buttonLayer"){
                        layer.removeFromSuperlayer()
                    }
                }
            sender.titleLabel?.alpha = 0.75
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == suitThick) {
            textField.text = textField.text?.replacingOccurrences(of: "mm", with: "")
        } else if (textField == wheight) {
            textField.text = textField.text?.replacingOccurrences(of: " kg", with: "")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text != "") {
            if (textField == suitThick) {
                textField.text = "\(textField.text ?? "")" + "mm"
            } else if (textField == wheight) {
                textField.text = "\(textField.text ?? "")" + " kg"
            }
        }
    }

    
    @objc func oneLayerButtonAction() {
        if oneLayerButton.currentBackgroundImage == UnselectedDot {
            oneLayerButton.setBackgroundImage(SelectedDot, for: .normal)
            twoLayerButton.setBackgroundImage(UnselectedDot, for: .normal)
        }
    }
    
    @objc func TwoLayerButtonAction() {
        if twoLayerButton.currentBackgroundImage == UnselectedDot {
            twoLayerButton.setBackgroundImage(SelectedDot, for: .normal)
            oneLayerButton.setBackgroundImage(UnselectedDot, for: .normal)
        }
    }
    
    func setupPicker(textField: UITextField, picker: UIPickerView) {
        picker.selectRow(0, inComponent: 0, animated: true)
        picker.backgroundColor = UIColor.systemGray6
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))
        
        doneButton.tintColor = UIColor(red: 0.07, green: 0.63, blue: 0.93, alpha: 1.00)
        cancelButton.tintColor = UIColor(red: 0.07, green: 0.63, blue: 0.93, alpha: 1.00)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    @objc func donePicker(sender: UIButton!) {
        suitType.resignFirstResponder()
        suitType.text = suitTypeText
    }
    
    @objc func cancelPicker(sender: UIButton!) {
        suitType.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView == picker) {
            return suitTypeArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == picker) {
           return suitTypeArray[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if (pickerView == picker) {
            self.suitTypeText = suitTypeArray[row]
        }
     
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
