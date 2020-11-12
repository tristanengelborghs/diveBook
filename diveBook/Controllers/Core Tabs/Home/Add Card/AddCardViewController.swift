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

class AddCardViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let uid = Auth.auth().currentUser!.uid
    
    let backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.11, alpha: 1.00)
    let topView = UIView()
    
    let DiveAgencieTexfield = UITextField()
    let skill = UITextField()
    let datePicker: UIDatePicker = UIDatePicker()
    var date = ""
    let idNumberTextField = UITextField()
    let checkbox = UISwitch()
    let diveInstructor = UITextField()
    var checkboxValue = false
    let diveCenter = UITextField()
    let photoView = UIButton()
    var photoBack = Data()
    var photoBackString: Data?
    
    let primaryLabel = UILabel()
    let verifiedByLabel = UILabel()
    
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    let gradientLayer = CAGradientLayer()
    let topColor = UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00)
    let bottomColor = UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00)
    var text: String = ""
    var text1: String = ""
    var constant = 0
    
    
    var picker = UIPickerView()
    var picker2 = UIPickerView()
    let diveAgencies = ["Select dive agencie", "NAUI", "PADI", "SSI", "BSAC", "CMAS", "SDI", "NELOS"]
    let diveSkilsPadi = ["Select dive skill","Open Water Diver", "Advanced Open Water Diver", "Rescue Diver", "Master Scuba Diver", "Dive Master", "Adaptive Support Diver", "Adventure Diver", "Scuba Diver", "Assistant Instructor", "Instructor"]
    let diveSkilsNaui = ["Select dive skill","Try Scuba", "Tandem Scuba Diver", "Scuba Diver", "Enriched Air Nitrox Diver", "Advanced Scuba Diver", "Rescue Scuba Diver", "Master Scuba Diver","First Aid Provider", "Night Diver", "Deep Diver", "Dive Master", "Instructor", "Instructor Crossover", "Instructor Trainer", "Course Director"]
    let diveSkilsSsi = ["Select dive skill","Scuba Diver", "Open Water Diver", "Enriched Air Nitrox","Night Diving", "Wreck Diving","Deep Diving", "Advanced Scuba Diver", "Rescue Scuba Diver", "Master Scuba Diver", "Dive Master", "Instructor"]
    let diveSkilsBsac = ["Select dive skill","Ocean Diver", "Sports Diver", "Dive Leader","Ice Diving", "Advanced Diver","First Class Diver"]
    let diveSkilsCmas = ["Select dive skill", "Introductory SCUBA", "Advanced Skills Diver", "Enriched Air Nitrox Diver","Underwater Navigation", "Night Diver","Rescue Diver", "Wreck Diver", "Cave Diver"]
    
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
        scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 820)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 44).isActive = true
        topView.setGradientBackground(colorTop: topColor, colorBottom: bottomColor)
    }
    
    func setupLayout() {
        scrollView.addSubview(topView)
        scrollView.addSubview(photoView)
        self.topView.addSubview(DiveAgencieTexfield)
        topView.addSubview(skill)
        scrollView.addSubview(idNumberTextField)
        scrollView.addSubview(checkbox)
        scrollView.addSubview(diveInstructor)
        scrollView.addSubview(diveCenter)
        scrollView.addSubview(verifiedByLabel)
        scrollView.addSubview(primaryLabel)
        
        //scrollView
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        //topView
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        topView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        topView.layer.cornerRadius = 20
        topView.clipsToBounds = true
        
        //datePicker
        scrollView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.heightAnchor.constraint(equalToConstant: 40).isActive = true
        datePicker.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 25).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        datePicker.timeZone = NSTimeZone.local
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .systemGray6
        datePicker.addTarget(self, action: #selector(AddCardViewController.datePickerValueChanged(_:)), for: .valueChanged)
        
        //idNumber
        idNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        idNumberTextField.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20).isActive = true
        idNumberTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        idNumberTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        idNumberTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        idNumberTextField.attributedPlaceholder = NSAttributedString(string: "ID Number",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        idNumberTextField.font = UIFont.init(name: "Avenir Next", size: 14)
        idNumberTextField.setDarkTextField(textfield: idNumberTextField)
        
        //switch
        checkbox.addTarget(self, action: #selector(AddCardViewController.switchStateDidChange(_:)), for: .valueChanged)
        checkbox.setOn(false, animated: false)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.topAnchor.constraint(equalTo: idNumberTextField.bottomAnchor, constant: 23).isActive = true
        checkbox.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        
        //primary label
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.topAnchor.constraint(equalTo: idNumberTextField.bottomAnchor, constant: 29).isActive = true
        primaryLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 20).isActive = true
        primaryLabel.font = UIFont.init(name: "Avenir Next", size: 14)
        primaryLabel.text = "Primary Label"
        
        verifiedByLabel.translatesAutoresizingMaskIntoConstraints = false
        verifiedByLabel.topAnchor.constraint(equalTo: checkbox.bottomAnchor, constant: 30).isActive = true
        verifiedByLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        verifiedByLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        verifiedByLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        verifiedByLabel.font = UIFont.init(name: "Avenir Next Bold", size: 14)
        verifiedByLabel.text = "Verified By"
        
        
        
        
        //Dive Instructor
        diveInstructor.translatesAutoresizingMaskIntoConstraints = false
        diveInstructor.topAnchor.constraint(equalTo: verifiedByLabel.bottomAnchor, constant: 10).isActive = true
        diveInstructor.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        diveInstructor.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        diveInstructor.heightAnchor.constraint(equalToConstant: 40).isActive = true
        diveInstructor.attributedPlaceholder = NSAttributedString(string: "Dive Instructor",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        diveInstructor.font = UIFont.init(name: "Avenir Next", size: 14)
        diveInstructor.setDarkTextField(textfield: diveInstructor)
        
        
        //Dive Center
        diveCenter.translatesAutoresizingMaskIntoConstraints = false
        diveCenter.topAnchor.constraint(equalTo: diveInstructor.bottomAnchor, constant: 20).isActive = true
        diveCenter.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        diveCenter.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        diveCenter.heightAnchor.constraint(equalToConstant: 40).isActive = true
        diveCenter.attributedPlaceholder = NSAttributedString(string: "Dive Center",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        diveCenter.font = UIFont.init(name: "Avenir Next", size: 14)
        diveCenter.setDarkTextField(textfield: diveCenter)
        
        
        //photoView
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        photoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        photoView.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 14)
        photoView.layer.cornerRadius = 10
        photoView.layer.borderColor = UIColor.white.cgColor
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.topAnchor.constraint(equalTo: diveCenter.bottomAnchor, constant: 40).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        photoView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 30).isActive = true
        photoView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -30).isActive = true
        photoView.backgroundColor = .systemGray5
        photoView.layer.borderWidth = 0
        photoView.layer.borderColor = UIColor.white.cgColor
        photoView.setTitle("photo of back", for: .normal)
        photoView.addTarget(self, action: #selector(photoTapped), for: .touchUpInside)
        photoView.contentMode = .scaleAspectFit
        photoView.clipsToBounds = true;
        
        DiveAgencieTexfield.translatesAutoresizingMaskIntoConstraints = false
        DiveAgencieTexfield.topAnchor.constraint(equalTo: topView.topAnchor, constant: 35).isActive = true
        DiveAgencieTexfield.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 30).isActive = true
        DiveAgencieTexfield.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        DiveAgencieTexfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        DiveAgencieTexfield.attributedPlaceholder = NSAttributedString(string: "Dive Organisation",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        DiveAgencieTexfield.font = UIFont.init(name: "Avenir Next", size: 14)
        DiveAgencieTexfield.setBottomBorderText(withColor: UIColor.white)
        
        skill.translatesAutoresizingMaskIntoConstraints = false
        skill.topAnchor.constraint(equalTo: DiveAgencieTexfield.bottomAnchor, constant: 20).isActive = true
        skill.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 30).isActive = true
        skill.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        skill.heightAnchor.constraint(equalToConstant: 40).isActive = true
        skill.attributedPlaceholder = NSAttributedString(string: "Dive skill",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        skill.font = UIFont.init(name: "Avenir Next", size: 14)
        skill.setBottomBorderText(withColor: UIColor.white)
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 250))
        
        picker2 = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 250))
        
        picker.selectRow(0, inComponent: 0, animated: true)
        
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
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        date = ("\(selectedDate)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let navItem = UINavigationItem(title: "Add Card")
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveCard))
        let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(closeVC))
        saveItem.tintColor = .white
        
        
        navItem.rightBarButtonItem = saveItem
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func saveCard(sender: UIButton!) {
        
        let Name = skill.text ?? "No certification selected"
        let Organisation = DiveAgencieTexfield.text ?? ""
        let Date = date 
        let ID = idNumberTextField.text ?? ""
        let Primary = checkboxValue
        let Instructor = diveInstructor.text ?? ""
        let DiveClub = diveCenter.text ?? ""
        let PhotoBack = photoBackString
        
        Firestore.firestore().collection("users").document(uid).collection("Cards").document("\(Organisation)" + " " + "\(Name)").setData([
            "Name": Name,
            "Organisation": Organisation,
            "Date": Date,
            "ID": ID,
            "Primary": Primary,
            "Instructor": Instructor,
            "DiveClub": DiveClub,
            "PhotoBack": PhotoBack as Any
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
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
        photoBack = resize(image: finalImage!)!
        photoBackString = photoBack
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
    
    @objc func switchStateDidChange(_ sender:UISwitch!)
    {
        if (sender.isOn == true){
            checkboxValue = true
        }
        else{
            checkboxValue = false
        }
    }
    
    func resize(image:UIImage) -> Data? {
        if let imageData = image.pngData(){ //if there is an image start the checks and possible compression
       let size = imageData.count / 1024
           if size > 1024 { //if the image data size is > 1024
           let compressionValue = CGFloat(1024 / size) //get the compression value needed in order to bring the image down to 1024
            return image.jpegData(compressionQuality: compressionValue) //return the compressed image data
           }
           else{ //if your image <= 1024 nothing needs to be done and return it as is
             return imageData
           }
       }
       else{ //if it cant get image data return nothing
           return nil
       }
   }
    
    
}
