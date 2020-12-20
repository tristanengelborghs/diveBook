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
    let maxTemp = UITextField()
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
        
        self.view.addSubview(waterTypeTitle)
        self.view.addSubview(waterType)
        self.view.addSubview(minTempTitle)
        self.view.addSubview(minTemp)
        self.view.addSubview(maxTempTitle)
        self.view.addSubview(maxTemp)
        self.view.addSubview(currentTitle)
        self.view.addSubview(current)
        self.view.addSubview(visibiltySlider)
        self.view.addSubview(visibilityTitle)
        self.view.addSubview(visibilityRating)
        self.view.addSubview(waves)
        self.view.addSubview(wavesTitle)
        
        minTemp.delegate = self
        maxTemp.delegate = self
        
        // water type Title
        waterTypeTitle.translatesAutoresizingMaskIntoConstraints = false
        waterTypeTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        waterTypeTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        waterTypeTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        waterTypeTitle.text = "Water type"
        waterTypeTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        waterTypeTitle.alpha = 0.75
        
        
        // date Textfield
        waterType.translatesAutoresizingMaskIntoConstraints = false
        waterType.topAnchor.constraint(equalTo: waterTypeTitle.bottomAnchor, constant: 10).isActive = true
        waterType.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        waterType.heightAnchor.constraint(equalToConstant: 40).isActive = true
        waterType.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        waterType.font = UIFont.init(name: "Avenir Next", size: 16)
        waterType.setDarkTextField(textfield: waterType)
        setupPicker(textField: waterType, picker: picker)
        waterType.text = waterConditionsArray.type
        waterType.attributedPlaceholder = NSAttributedString(string: "Select water type...",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        // minimum temperature title
        minTempTitle.translatesAutoresizingMaskIntoConstraints = false
        minTempTitle.topAnchor.constraint(equalTo: waterType.bottomAnchor, constant: 20).isActive = true
        minTempTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        minTempTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        minTempTitle.text = "Min temperture"
        minTempTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        minTempTitle.alpha = 0.75
        
        // minimum temperature textfield
        minTemp.translatesAutoresizingMaskIntoConstraints = false
        minTemp.topAnchor.constraint(equalTo: minTempTitle.bottomAnchor, constant: 10).isActive = true
        minTemp.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        minTemp.heightAnchor.constraint(equalToConstant: 40).isActive = true
        minTemp.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -10).isActive = true
        minTemp.font = UIFont.init(name: "Avenir Next", size: 16)
        minTemp.setDarkTextField(textfield: minTemp)
        minTemp.text = waterConditionsArray.minTemp
        minTemp.keyboardType = UIKeyboardType.decimalPad
        minTemp.attributedPlaceholder = NSAttributedString(string: "0 °C",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        // maximum temperature title
        maxTempTitle.translatesAutoresizingMaskIntoConstraints = false
        maxTempTitle.topAnchor.constraint(equalTo: waterType.bottomAnchor, constant: 20).isActive = true
        maxTempTitle.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10).isActive = true
        maxTempTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        maxTempTitle.text = "Max temperature"
        maxTempTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        maxTempTitle.alpha = 0.75
        
        // maximum temperature textfield
        maxTemp.translatesAutoresizingMaskIntoConstraints = false
        maxTemp.topAnchor.constraint(equalTo: minTempTitle.bottomAnchor, constant: 10).isActive = true
        maxTemp.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10).isActive = true
        maxTemp.heightAnchor.constraint(equalToConstant: 40).isActive = true
        maxTemp.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        maxTemp.font = UIFont.init(name: "Avenir Next", size: 16)
        maxTemp.setDarkTextField(textfield: maxTemp)
        maxTemp.text = waterConditionsArray.maxTemp
        maxTemp.keyboardType = UIKeyboardType.decimalPad
        maxTemp.attributedPlaceholder = NSAttributedString(string: "0 C°",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        // water type Title
        wavesTitle.translatesAutoresizingMaskIntoConstraints = false
        wavesTitle.topAnchor.constraint(equalTo: maxTemp.bottomAnchor, constant: 20).isActive = true
        wavesTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        wavesTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        wavesTitle.text = "Waves"
        wavesTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        wavesTitle.alpha = 0.75
        
        // date Textfield
        waves.translatesAutoresizingMaskIntoConstraints = false
        waves.topAnchor.constraint(equalTo: wavesTitle.bottomAnchor, constant: 10).isActive = true
        waves.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        waves.heightAnchor.constraint(equalToConstant: 40).isActive = true
        waves.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        waves.font = UIFont.init(name: "Avenir Next", size: 16)
        waves.setDarkTextField(textfield: waves)
        setupPicker(textField: waves, picker: picker3)
        waves.text = waterConditionsArray.waves
        waves.attributedPlaceholder = NSAttributedString(string: "Select wave type...",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        // rating title
        visibilityTitle.translatesAutoresizingMaskIntoConstraints = false
        visibilityTitle.topAnchor.constraint(equalTo: waves.bottomAnchor, constant: 20).isActive = true
        visibilityTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        visibilityTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        visibilityTitle.text = "Visibility"
        visibilityTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        visibilityTitle.alpha = 0.75
        
        // rating value
        visibilityRating.translatesAutoresizingMaskIntoConstraints = false
        visibilityRating.topAnchor.constraint(equalTo: waves.bottomAnchor, constant: 20).isActive = true
        visibilityRating.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        visibilityRating.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        visibilityRating.text = waterConditionsArray.visibility
        visibilityRating.font = UIFont.init(name: "Avenir Next", size: 16)
        visibilityRating.alpha = 0.75
        visibilityRating.textAlignment = .right
        
        // rating slider
        visibiltySlider.translatesAutoresizingMaskIntoConstraints = false
        visibiltySlider.topAnchor.constraint(equalTo: visibilityTitle.bottomAnchor, constant: 20).isActive = true
        visibiltySlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        visibiltySlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        visibiltySlider.minimumValue = 0
        visibiltySlider.maximumValue = 30
        visibiltySlider.value = Float(waterConditionsArray.visibility.replacingOccurrences(of: "m", with: ""))!
        visibiltySlider.isContinuous = true
        visibiltySlider.tintColor = UIColor(red: 0.07, green: 0.45, blue: 0.70, alpha: 1.00)
        visibiltySlider.addTarget(self, action: #selector(NormalDiveViewController.sliderValueDidChange(_:)), for: .valueChanged)
        
        // water type Title
        currentTitle.translatesAutoresizingMaskIntoConstraints = false
        currentTitle.topAnchor.constraint(equalTo: visibiltySlider.bottomAnchor, constant: 20).isActive = true
        currentTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        currentTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        currentTitle.text = "Current"
        currentTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        currentTitle.alpha = 0.75
        
        // date Textfield
        current.translatesAutoresizingMaskIntoConstraints = false
        current.topAnchor.constraint(equalTo: currentTitle.bottomAnchor, constant: 10).isActive = true
        current.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        current.heightAnchor.constraint(equalToConstant: 40).isActive = true
        current.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        current.font = UIFont.init(name: "Avenir Next", size: 16)
        current.setDarkTextField(textfield: current)
        setupPicker(textField: current, picker: picker2)
        current.text = waterConditionsArray.current
        current.attributedPlaceholder = NSAttributedString(string: "Select type of current...",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
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
