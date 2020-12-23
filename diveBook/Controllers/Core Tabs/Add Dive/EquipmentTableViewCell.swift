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
    var checkboxIndex: NSIndexPath = NSIndexPath()

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
    let row1 = UIStackView()
    let row2 = UIStackView()
    let row3 = UIStackView()
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
    
    //checkbox
    let checkButton = UIButton()
    
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
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 0).isActive = true
        wordLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        wordLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        wordLabel.text = ""
        wordLabel.numberOfLines = 0
        wordLabel.lineBreakMode = .byWordWrapping
        
        stackView.addSubview(editbutton)
        editbutton.translatesAutoresizingMaskIntoConstraints = false
       // editbutton.leadingAnchor.constraint(equalTo: wordLabel.trailingAnchor, constant: 20).isActive = true
        editbutton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
        editbutton.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        editbutton.setTitle("edit", for: .normal)
        editbutton.titleLabel?.font =  UIFont(name: "Avenir Next", size: 16)
        editbutton.titleLabel?.alpha = 0.75
        editbutton.addTarget(self, action: #selector(toggleView), for: .touchUpInside)
        
        //checkbox
        stackView.addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        checkButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        checkButton.frame = CGRect(x: 100, y: 100, width: 130, height: 130)
        checkButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        checkButton.tintColor = .white
        checkButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
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
        suitTypeTitle.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        suitTypeTitle.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -30).isActive = true
        suitTypeTitle.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 0).isActive = true
        suitTypeTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        suitTypeTitle.alpha = 0.75
        
        // suit type textfield
        suitType.setDarkTextField(textfield: suitType)
        suitType.translatesAutoresizingMaskIntoConstraints = false
        suitType.topAnchor.constraint(equalTo: suitTypeTitle.bottomAnchor, constant: 10).isActive = true
        suitType.trailingAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: -10).isActive = true
        suitType.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 0).isActive = true
        suitType.font = UIFont.init(name: "Avenir Next", size: 16)
        setupPicker(textField: suitType, picker: picker)
        suitThick.delegate = self
        suitType.attributedPlaceholder = NSAttributedString(string: "Select here...",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        // suit thickness title
        suitThickTitle.translatesAutoresizingMaskIntoConstraints = false
        suitThickTitle.text = "Thickness"
        suitThickTitle.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        suitThickTitle.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: 0).isActive = true
        suitThickTitle.leftAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 10).isActive = true
        suitThickTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        suitThickTitle.alpha = 0.75
        
        // suit thickness textfield
        suitThick.setDarkTextField(textfield: suitThick)
        suitThick.translatesAutoresizingMaskIntoConstraints = false
        suitThick.topAnchor.constraint(equalTo: suitThickTitle.bottomAnchor, constant: 10).isActive = true
        suitThick.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0).isActive = true
        suitThick.leftAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 10).isActive = true
        suitThick.font = UIFont.init(name: "Avenir Next", size: 16)
        suitThick.keyboardType = UIKeyboardType.decimalPad
        suitThick.attributedPlaceholder = NSAttributedString(string: "0mm",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        // One layer button
        oneLayerButton.translatesAutoresizingMaskIntoConstraints = false
        oneLayerButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 0).isActive = true
        oneLayerButton.topAnchor.constraint(equalTo: suitThick.bottomAnchor, constant: 20).isActive = true
        oneLayerButton.tintColor = .white
        oneLayerButton.frame = CGRect(x: 100, y: 100, width: 130, height: 130)
        oneLayerButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        oneLayerButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        oneLayerButton.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
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
        twoLayerButton.tintColor = .white
        twoLayerButton.frame = CGRect(x: 100, y: 100, width: 130, height: 130)
        twoLayerButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        twoLayerButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        twoLayerButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
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
        wheightTitle.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: 0).isActive = true
        wheightTitle.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 0).isActive = true
        wheightTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        wheightTitle.alpha = 0.75
        
        // suit thickness textfield
        wheight.setDarkTextField(textfield: wheight)
        wheight.translatesAutoresizingMaskIntoConstraints = false
        wheight.topAnchor.constraint(equalTo: wheightTitle.bottomAnchor, constant: 10).isActive = true
        wheight.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0).isActive = true
        wheight.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 0).isActive = true
        wheight.font = UIFont.init(name: "Avenir Next", size: 16)
        wheight.keyboardType = UIKeyboardType.decimalPad
        wheight.delegate = self
        wheight.attributedPlaceholder = NSAttributedString(string: "0 kg",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        multipleChoiceConfigure()
        
        
        
        
        // height anchors
        topView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        bottomView.heightAnchor.constraint(greaterThanOrEqualTo: bottomView.heightAnchor).isActive = true
        suitType.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        suitThick.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        oneLayerLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        twoLayerLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        wheight.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        multipleChoiceView.heightAnchor.constraint(greaterThanOrEqualToConstant: 130).isActive = true

        // stackview constraints
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor,constant: 10).isActive = true

    }
    
    func multipleChoiceConfigure() {
        bottomView.addSubview(multipleChoiceView)
        bottomView.addSubview(hood)
        bottomView.addSubview(hoodVest)
        bottomView.addSubview(gloves)
        bottomView.addSubview(reefHook)
        bottomView.addSubview(compass)
        bottomView.addSubview(knife)
        
        createRow(stack: row3)
        row3.topAnchor.constraint(equalTo: multipleChoiceView.topAnchor, constant: 0).isActive = true
        addToRow(stack: row3, item: reefHook, name: "Reefhook")
        addToRow(stack: row3, item: compass, name: "compass")
        addToRow(stack: row3, item: knife, name: "Knife")
        
        createRow(stack: row1)
        row1.topAnchor.constraint(equalTo: reefHook.bottomAnchor, constant: 10).isActive = true
        addToRow(stack: row1, item: hood, name: "Hood")
        addToRow(stack: row1, item: hoodVest, name: "Hood vest")
        addToRow(stack: row1, item: gloves, name: "Gloves")
        
        createRow(stack: row2)
        row2.topAnchor.constraint(equalTo: hood.bottomAnchor, constant: 10).isActive = true
        addToRow(stack: row2, item: dryGloves, name: "Dry gloves")
        addToRow(stack: row2, item: buoy, name: "Buoy")
        addToRow(stack: row2, item: torch, name: "Torch")

        multipleChoiceView.translatesAutoresizingMaskIntoConstraints = false
        multipleChoiceView.topAnchor.constraint(equalTo: wheight.bottomAnchor, constant: 25).isActive = true
        multipleChoiceView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 0).isActive = true
        multipleChoiceView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0).isActive = true
        multipleChoiceView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func addToRow(stack: UIStackView, item: UIButton, name: String) {
        stack.addArrangedSubview(item)
        createEquipment(button: item, name: "\(name)")
        item.addTarget(self, action: #selector(connected), for: .touchUpInside)
    }
    
    func createRow(stack: UIStackView) {
        stack.axis  = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 0).isActive = true
    }
    
    func createEquipment(button: UIButton, name: String) {
        button.backgroundColor = .systemGray5
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5,right: 15)
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
    
    @objc func checkboxTapped(sender: UIButton!) {
        checkboxIndex = NSIndexPath(row: sender.tag, section: 0)
        checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        delegate?.checkboxReload(indexPatch: sender)
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
        if oneLayerButton.currentBackgroundImage == UIImage(systemName: "circle") {
            oneLayerButton.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
            twoLayerButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    @objc func TwoLayerButtonAction() {
        if twoLayerButton.currentBackgroundImage == UIImage(systemName: "circle") {
            twoLayerButton.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
            oneLayerButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
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
