//
//  EquipmentTableViewCell.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 20/12/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    var suitTypeArray: [String] = ["","Swim", "Short", "Wet", "Semi-Dry", "Dry"]
    let stackView = UIStackView()
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabels()
    }

    func setupLabels() {

        selectionStyle = .none

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)

        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.textAlignment = .center
        wordLabel.text = ""
        wordLabel.numberOfLines = 0
        wordLabel.lineBreakMode = .byWordWrapping
        stackView.addArrangedSubview(wordLabel)
        
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
        bottomView.isHidden = true

        suitTypeTitle.translatesAutoresizingMaskIntoConstraints = false
        suitTypeTitle.text = "Suit type"
        suitTypeTitle.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20).isActive = true
        suitTypeTitle.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -45).isActive = true
        suitTypeTitle.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 45).isActive = true
        suitTypeTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        suitTypeTitle.alpha = 0.75
        
        suitType.setDarkTextField(textfield: suitType)
        suitType.translatesAutoresizingMaskIntoConstraints = false
        suitType.topAnchor.constraint(equalTo: suitTypeTitle.bottomAnchor, constant: 10).isActive = true
        suitType.trailingAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: -10).isActive = true
        suitType.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 45).isActive = true
        suitType.font = UIFont.init(name: "Avenir Next", size: 16)
        setupPicker(textField: suitType, picker: picker)
        suitType.attributedPlaceholder = NSAttributedString(string: "Select here...",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        suitThickTitle.translatesAutoresizingMaskIntoConstraints = false
        suitThickTitle.text = "Thickness"
        suitThickTitle.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20).isActive = true
        suitThickTitle.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -45).isActive = true
        suitThickTitle.leftAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 10).isActive = true
        suitThickTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        suitThickTitle.alpha = 0.75
        
        suitThick.setDarkTextField(textfield: suitThick)
        suitThick.translatesAutoresizingMaskIntoConstraints = false
        suitThick.topAnchor.constraint(equalTo: suitThickTitle.bottomAnchor, constant: 10).isActive = true
        suitThick.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -45).isActive = true
        suitThick.leftAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 10).isActive = true
        suitThick.font = UIFont.init(name: "Avenir Next", size: 16)
        suitThick.attributedPlaceholder = NSAttributedString(string: "0mm",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        // One layer button
        oneLayerButton.translatesAutoresizingMaskIntoConstraints = false
        oneLayerButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 45).isActive = true
        oneLayerButton.topAnchor.constraint(equalTo: suitThick.bottomAnchor, constant: 20).isActive = true
        oneLayerButton.frame = CGRect(x: 100, y: 100, width: 130, height: 130)
        oneLayerButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        oneLayerButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
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
        twoLayerButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -20).isActive = true
        twoLayerButton.frame = CGRect(x: 100, y: 100, width: 130, height: 130)
        twoLayerButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        twoLayerButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        twoLayerButton.setBackgroundImage(UnselectedDot, for: .normal)
        twoLayerButton.addTarget(self, action: #selector(TwoLayerButtonAction), for: .touchUpInside)
        
        // Two layers label
        twoLayerLabel.translatesAutoresizingMaskIntoConstraints = false
        twoLayerLabel.centerYAnchor.constraint(equalTo: twoLayerButton.centerYAnchor, constant: 0).isActive = true
        twoLayerLabel.leadingAnchor.constraint(equalTo: twoLayerButton.trailingAnchor, constant: 15).isActive = true
        twoLayerLabel.text = "Two layers"
        twoLayerLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        twoLayerLabel.alpha = 0.75
        
        
        
        
        
        
        
        
        

        wordLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        bottomView.heightAnchor.constraint(greaterThanOrEqualTo: bottomView.heightAnchor).isActive = true
        suitType.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        suitThick.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        oneLayerLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        twoLayerLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true

        stackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor,constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor,constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor,constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor,constant: 10).isActive = true

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
