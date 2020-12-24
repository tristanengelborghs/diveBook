//
//  ConditionsViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 18/12/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class ConditionsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let waterTypeTitle = UILabel()
    var waterTypeText: String = ""
    let waterType = UITextField()
    var picker = UIPickerView()
    let minTempTitle = UILabel()
    let minTempLabel = UILabel()
    let minTemp = UITextField()
    let maxTempTitle = UILabel()
    let maxTempLabel = UILabel()
    let maxTemp:UITextField = UITextField()
    let currentTitle = UILabel()
    var currentText: String = ""
    let current = UITextField()
    var picker2 = UIPickerView()
    let visibilityTitle = UILabel()
    let visibilityRating = UILabel()
    let visibiltySlider = UISlider(frame:CGRect(x: 10, y: 100, width: 300, height: 20))
    let step : Float = 1
    var picker3 = UIPickerView()
    let wavesTitle = UILabel()
    var wavesText: String = ""
    let waves = UITextField()
    
    let waterTypeArray = ["Select water type", "Salt", "Fresh", "1.000 kg/l", "1.050 kg/l", "1.100 kg/l", "1.150 kg/l", "1.200 kg/l", "1.250 kg/l"]
    let currentArray = ["Select type of current", "None", "Light", "Medium", "Strong"]
    let wavesArray = ["Select wave type", "Flat", "Low waves", "Medium waves", "High waves"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray6
        setupNavBar()
        setupLayout()
    }
    
    func setupLayout() {
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 250))
        picker2 = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 250))
        picker3 = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 250))
        
        [waterTypeTitle, waterType, minTempTitle, minTemp, maxTemp, maxTempTitle, currentTitle, current, visibiltySlider, visibilityTitle, visibilityRating, waves, wavesTitle].forEach { self.view.addSubview($0) }
        
        minTemp.delegate = self
        maxTemp.delegate = self
        
        // water type Title
        waterTypeTitle.setTitle(name: "Water type")
        waterTypeTitle.anchorLabel(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 80, left: 45, bottom: 0, right: 45))
        
        // water type Textfield
        waterType.configure(placeholder: "Select water Type", textInput: waterConditionsArray.type)
        setupPicker(textField: waterType, picker: picker)
        waterType.anchorTextfield(top: waterTypeTitle.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 10, left: 45, bottom: 0, right: 45), size: .init(width: 0, height: 40))
        
        // minimum temperature title
        minTempTitle.setTitle(name: "Min temperature")
        minTempTitle.anchorLabel(top: waterType.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 20, left: 45, bottom: 0, right: 45))
        
        // minimum temperature textfield
        minTemp.configure(placeholder: "0 °C", textInput: waterConditionsArray.minTemp)
        minTemp.keyboardType = UIKeyboardType.decimalPad
        minTemp.anchorTextfield(top: minTempTitle.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.centerXAnchor, padding: .init(top: 10, left: 45, bottom: 0, right: 10), size: .init(width: 0, height: 40))
        
        // maximum temperature title
        maxTempTitle.setTitle(name: "Max temperature")
        maxTempTitle.anchorLabel(top: waterType.bottomAnchor, leading: self.view.centerXAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 45))
        
        // maximum temperature textfield
        maxTemp.keyboardType = UIKeyboardType.decimalPad
        maxTemp.anchorTextfield(top: minTempTitle.bottomAnchor, leading: self.view.centerXAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 45), size: .init(width: 0, height: 40))
        maxTemp.configure(placeholder: "0 °C", textInput: waterConditionsArray.maxTemp)
        
        // waves Title
        wavesTitle.setTitle(name: "Waves")
        wavesTitle.anchorLabel(top: maxTemp.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 20, left: 45, bottom: 0, right: 45))
        
        // waves Textfield
        waves.configure(placeholder: "Select wave type", textInput: waterConditionsArray.waves)
        setupPicker(textField: waves, picker: picker3)
        waves.anchorTextfield(top: wavesTitle.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 10, left: 45, bottom: 0, right: 45), size: .init(width: 0, height: 40))
        
        // rating title
        visibilityTitle.setTitle(name: "Visibility")
        visibilityTitle.anchorLabel(top: waves.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 20, left: 45, bottom: 0, right: 45))
        
        // rating value
        visibilityRating.text = waterConditionsArray.visibility
        visibilityRating.font = UIFont.init(name: "Avenir Next", size: 16)
        visibilityRating.alpha = 0.75
        visibilityRating.textAlignment = .right
        visibilityRating.anchorLabel(top: waves.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 20, left: 45, bottom: 0, right: 45))
        
        // rating slider
        visibiltySlider.minimumValue = 0
        visibiltySlider.maximumValue = 30
        visibiltySlider.value = Float(waterConditionsArray.visibility.replacingOccurrences(of: "m", with: ""))!
        visibiltySlider.isContinuous = true
        visibiltySlider.tintColor = UIColor(red: 0.07, green: 0.45, blue: 0.70, alpha: 1.00)
        visibiltySlider.addTarget(self, action: #selector(NormalDiveViewController.sliderValueDidChange(_:)), for: .valueChanged)
        visibiltySlider.anchorSlider(top: visibilityTitle.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 20, left: 45, bottom: 0, right: 45))
        
        // current Title
        currentTitle.setTitle(name: "Current")
        currentTitle.anchorLabel(top: visibiltySlider.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 20, left: 45, bottom: 0, right: 45))
        
        // current Textfield
        current.configure(placeholder: "Select type of current", textInput: waterConditionsArray.current)
        setupPicker(textField: current, picker: picker2)
        current.anchorTextfield(top: currentTitle.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 10, left: 45, bottom: 0, right: 45), size: .init(width: 0, height: 40))
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = textField.text?.replacingOccurrences(of: " °C", with: "")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text != "") {
            textField.text = "\(textField.text ?? "")" + " °C"
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
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        visibilityRating.text = "\(Int(roundedStepValue))m"
    }
    
    @objc func saveWaterConditions(sender: UIButton!) {
        if let presenter = presentingViewController as? NormalDiveViewController {
            let type: String = "\(waterType.text ?? "")"
            let minTempText: String = "\(minTemp.text ?? "")"
            let maxTempText: String = "\(maxTemp.text ?? "")"
            let waveText: String = "\(waves.text ?? "")"
            let visibilityText: String = "\(visibilityRating.text ?? "")"
            let currentsText: String = "\(current.text ?? "")"
            
            waterConditionsArray.type = type
            waterConditionsArray.minTemp = minTempText
            waterConditionsArray.maxTemp = maxTempText
            waterConditionsArray.waves = waveText
            waterConditionsArray.visibility = visibilityText
            waterConditionsArray.current = currentsText
            
            if (type != "" || minTempText != "" || maxTempText != "" || waveText != "" || visibilityText != "0m" || currentsText != "") {
                presenter.conditions.setTitleColor(.white, for: .normal)
                presenter.conditions.setTitle("completed", for: .normal)
                presenter.completion.isHidden = false
            } else {
                presenter.conditions.setTitleColor(.gray, for: .normal)
                presenter.conditions.setTitle("Select here...", for: .normal)
                presenter.completion.isHidden = true
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closeVC(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView == picker) {
            return waterTypeArray.count
        } else if (pickerView == picker2) {
            return currentArray.count
        } else if (pickerView == picker3) {
            return wavesArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == picker) {
           return waterTypeArray[row]
        } else if (pickerView == picker2) {
            return currentArray[row]
        } else if (pickerView == picker3) {
            return wavesArray[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if (pickerView == picker) {
            self.waterTypeText = waterTypeArray[row]
        } else if (pickerView == picker2) {
            self.currentText = currentArray[row]
        } else if (pickerView == picker3) {
            self.wavesText = wavesArray[row]
        }
     
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @objc func donePicker() {
        waterType.resignFirstResponder()
        waterType.text = waterTypeText
        
        current.resignFirstResponder()
        current.text = currentText
        
        waves.resignFirstResponder()
        waves.text = wavesText
    }
    
    @objc func cancelPicker() {
        current.resignFirstResponder()
        waterType.resignFirstResponder()
        waves.resignFirstResponder()
    }
    
    func setupNavBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        navBar.isTranslucent = false
        navBar.barTintColor = UIColor.systemGray5
        navBar.shadowImage = UIImage()
        view.addSubview(navBar)
        
        let navItem = UINavigationItem(title: "Water conditions")
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveWaterConditions))
        let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(closeVC))
        saveItem.tintColor = .white
        
        
        navItem.rightBarButtonItem = saveItem
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
    }


}

