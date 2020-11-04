//
//  AddCardViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 01/11/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit


class AddCardViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.11, alpha: 1.00)
    let topView = UIView()
    let photoView = UIButton()
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    let gradientLayer = CAGradientLayer()
    let topColor = UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00)
    let bottomColor = UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00)
    var text: String = ""
    var text1: String = ""
    
    var picker = UIPickerView()
    var picker2 = UIPickerView()
    let diveAgencies = ["NAUI", "PADI", "SSI", "BSAC", "CMAS", "SDI", "NELOS"]
    let diveSkils = ["hello", "PADI", "SSI", "BSAC", "CMAS", "SDI", "NELOS"]
    let diveSkilsPadi = ["Open Water Diver", "Advanced Open Water Diver", "Rescue Diver", "Master Scuba Diver", "Dive Master", "Adaptive Support Diver", "Adventure Diver", "Scuba Diver", "Assistant Instructor", "Instructor"]
    let diveSkilsNaui = ["Try Scuba", "Tandem Scuba Diver", "Scuba Diver", "Enriched Air Nitrox Diver", "Advanced Scuba Diver", "Rescue Scuba Diver", "Master Scuba Diver","First Aid Provider", "Night Diver", "Deep Diver", "Dive Master", "Instructor", "Instructor Crossover", "Instructor Trainer", "Course Director"]
    let diveSkilsSsi = ["Scuba Diver", "Open Water Diver", "Enriched Air Nitrox","Night Diving", "Wreck Diving","Deep Divng", "Advanced Scuba Diver", "Rescue Scuba Diver", "Master Scuba Diver", "Dive Master", "Instructor"]
    let diveSkilsBsac = ["Ocean Diver", "Sports Diver", "Dive Leader","Ice Diving", "Advanced Diver","First Class Diver"]
    let diveSkilsCmas = ["Introductory SCUBA", "Advanced Skills Diver", "Enriched Air Nitrox Diver","Underwater Navigation", "Night Diver","Rescue Diver", "Wreck Diver", "Cave Diver"]
    
    let DiveAgencieTexfield = UITextField()
    let skill = UITextField()
    let number = UITextField()
    
    let colors = Colors()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        view.backgroundColor = backgroundColor
        setupNavBar()
        setupLayout()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 5678)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 44).isActive = true
        topView.setGradientBackground(colorTop: topColor, colorBottom: bottomColor)
    }

    func setupLayout() {
        scrollView.addSubview(topView)
        scrollView.addSubview(photoView)
        self.topView.addSubview(DiveAgencieTexfield)
        topView.addSubview(skill)
        scrollView.addSubview(number)
        
        //scrollView
        scrollView.isScrollEnabled = true
        //topView
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 44).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        topView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        //photoView
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        photoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        photoView.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 14)
        photoView.layer.cornerRadius = 10
        photoView.layer.borderColor = UIColor.white.cgColor
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        photoView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 30).isActive = true
        photoView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -30).isActive = true
        photoView.backgroundColor = backgroundColor
        photoView.layer.borderWidth = 1
        photoView.layer.borderColor = UIColor.white.cgColor
        photoView.setTitle("add a photo", for: .normal)
        photoView.addTarget(self, action: #selector(photoTapped), for: .touchUpInside)
        photoView.contentMode = .scaleAspectFit
        photoView.clipsToBounds = true;
        
        DiveAgencieTexfield.translatesAutoresizingMaskIntoConstraints = false
        DiveAgencieTexfield.topAnchor.constraint(equalTo: topView.topAnchor, constant: 35).isActive = true
        DiveAgencieTexfield.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 50).isActive = true
        DiveAgencieTexfield.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        DiveAgencieTexfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        DiveAgencieTexfield.attributedPlaceholder = NSAttributedString(string: "Dive Organisation",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        DiveAgencieTexfield.font = UIFont.init(name: "Avenir Next", size: 14)
        DiveAgencieTexfield.setBottomBorderText(withColor: UIColor.white)
        
        skill.translatesAutoresizingMaskIntoConstraints = false
        skill.topAnchor.constraint(equalTo: DiveAgencieTexfield.bottomAnchor, constant: 20).isActive = true
        skill.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 50).isActive = true
        skill.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        skill.heightAnchor.constraint(equalToConstant: 40).isActive = true
        skill.attributedPlaceholder = NSAttributedString(string: "Dive skill",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        skill.font = UIFont.init(name: "Avenir Next", size: 14)
        skill.setBottomBorderText(withColor: UIColor.white)
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 250))
                              
        picker2 = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 250))
        
        picker.backgroundColor = backgroundColor
        picker.delegate = self
        picker.dataSource = self
        
        picker2.backgroundColor = backgroundColor
        picker2.delegate = self
        picker2.dataSource = self

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

        DiveAgencieTexfield.inputView = picker
        DiveAgencieTexfield.inputAccessoryView = toolBar
        
        skill.inputView = picker2
        skill.inputAccessoryView = toolBar
        
    }
    
    func OrganisationChooser() -> [String]{
        if (DiveAgencieTexfield.text == "PADI") {
            return diveSkilsPadi
        } else if (DiveAgencieTexfield.text == "NAUI") {
            return diveSkilsNaui
        } else if (DiveAgencieTexfield.text == "SSI") {
            return diveSkilsSsi
        } else if (DiveAgencieTexfield.text == "BSAC") {
            return diveSkilsBsac
        } else if (DiveAgencieTexfield.text == "CMAS") {
            return diveSkilsCmas
        }
        return ["First Select A Dive Organisation"]
    }
    
    func setupNavBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        navBar.isTranslucent = false
        navBar.barTintColor = backgroundColor
        navBar.shadowImage = UIImage()
        view.addSubview(navBar)

        let navItem = UINavigationItem(title: "")
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveCard))
        let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(closeVC))
        saveItem.tintColor = .white
        
        
        navItem.rightBarButtonItem = saveItem
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func saveCard(sender: UIButton!) {
        
    }
    
    @objc func closeVC(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func photoTapped(sender: UIButton!) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        
        let finalImage = UIImage(data: imageData)
        photoView.setImage(finalImage, for: .normal)
        photoView.layer.borderWidth = 0
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == picker) {
            return diveAgencies.count
        } else if (pickerView == picker2) {
            return OrganisationChooser().count
        }
        return diveAgencies.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == picker) {
            return diveAgencies[row]
        } else if (pickerView == picker2) {
            return OrganisationChooser()[row]
        }
        return diveAgencies[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == picker) {
            self.text1 = diveAgencies[row]
        } else if (pickerView == picker2) {
            self.text = OrganisationChooser()[row]
        }
        
        
    }

    @objc func donePicker() {

        DiveAgencieTexfield.resignFirstResponder()
        DiveAgencieTexfield.text = text1
        
        skill.text = text
        skill.resignFirstResponder()

    }
    
    @objc func cancelPicker() {

        DiveAgencieTexfield.resignFirstResponder()
        
        
        
        skill.resignFirstResponder()

    }
    

}

