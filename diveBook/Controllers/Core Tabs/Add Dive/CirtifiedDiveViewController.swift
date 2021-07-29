//
//  CirtifiedDiveViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 28/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FloatingPanel

protocol CirtifiedDiveViewControllerDelegate: AnyObject {
    func CirtifiedDiveViewController(_ vc: CirtifiedDiveViewController)
}

class CirtifiedDiveViewController: UIViewController, UITextFieldDelegate {
    
    private let scrollView = UIScrollView()
    private let pageControll: UIPageControl = {
        let pageControll = UIPageControl()
        pageControll.numberOfPages = 3
        return pageControll
    }()
    let page1 = UIView(frame: CGRect(x: 0 * UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let page2 = UIView(frame: CGRect(x: 1 * UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var tabBarHeight:CGFloat = 0.0
    let uid = Auth.auth().currentUser!.uid
    let saveButton = UIButton()
    let diveNr = UITextField()
    weak var delegate: CirtifiedDiveViewControllerDelegate?
    
    let location = UITextField()
    let divePoint = UITextField()
    
    let datePicker: UIDatePicker = UIDatePicker()
    let dateTextField = UITextField()
    let formatter = DateFormatter()
    let currentDateTime = Date()
    var timeDateText = ""
    let diveTime = UITextField()
    let maxDepth = UITextField()
    
    let topColor = UIColor(red: 0.07, green: 0.52, blue: 0.63, alpha: 1.00)
    let bottomColor = UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00)
    var colors = [UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00).cgColor, UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00).cgColor]
    let navBar = UINavigationBar(frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 44))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.addSubview(pageControll)
        
        pageControll.addTarget(self, action: #selector(pageControllDidChange(_:)), for: .valueChanged)
        scrollView.delegate = self
    
        setGradient()
        setupNavBar()
        page1Setup()
        page2Setup()
        
        setupTextfields()
        FetchData.sharedInstance.fetchDiveNr { (diveNr) in
            let diveNr = diveNr
            self.diveNr.text = "\(diveNr + 1)"
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        scrollView.contentSize = CGSize(width: view.frame.size.width*3, height: view.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        tabBarHeight = view.safeAreaInsets.bottom
        
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        pageControll.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -tabBarHeight - 10).isActive = true
        pageControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        pageControll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        pageControll.heightAnchor.constraint(equalToConstant: 70).isActive = true
        //pageControll.frame = CGRect(x: 10, y: view.frame.size.height-100, width: view.frame.size.width-20, height: 70)
        
        location.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -tabBarHeight-50).isActive = true
    }
    
    @objc private func pageControllDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 3*view.frame.size.width, height: view.frame.size.height)
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func page1Setup() {
        scrollView.addSubview(page1)
        
        page1.addSubview(location)
        page1.addSubview(divePoint)
        
        location.translatesAutoresizingMaskIntoConstraints = false
        location.centerXAnchor.constraint(equalTo: page1.centerXAnchor).isActive = true
        location.heightAnchor.constraint(equalToConstant: 40).isActive = true
        location.widthAnchor.constraint(equalToConstant: view.frame.size.width-90).isActive = true
        location.font = UIFont.init(name: "Avenir Next", size: 16)
        location.setBottomBorderText(withColor: UIColor.white)
        location.textAlignment = .center
        location.attributedPlaceholder = NSAttributedString(string: "Location",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        divePoint.translatesAutoresizingMaskIntoConstraints = false
        divePoint.centerXAnchor.constraint(equalTo: page1.centerXAnchor).isActive = true
        divePoint.topAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 0).isActive = true
        divePoint.heightAnchor.constraint(equalToConstant: 40).isActive = true
        divePoint.widthAnchor.constraint(equalToConstant: view.frame.size.width-90).isActive = true
        divePoint.font = UIFont.init(name: "Avenir Next", size: 16)
        divePoint.setBottomBorderText(withColor: UIColor.white)
        divePoint.textAlignment = .center
        divePoint.attributedPlaceholder = NSAttributedString(string: "Dive site",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        location.delegate = self
        divePoint.delegate = self
        
    }
    
    func page2Setup() {
        scrollView.addSubview(page2)
        
        page2.addSubview(dateTextField)
        page2.addSubview(diveTime)
        page2.addSubview(maxDepth)
        
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        dateTextField.leadingAnchor.constraint(equalTo: page2.leadingAnchor, constant: 45).isActive = true
        dateTextField.trailingAnchor.constraint(equalTo: page2.trailingAnchor, constant: -45).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateTextField.font = UIFont.init(name: "Avenir Next", size: 16)
        
        dateTextField.layer.cornerRadius = 5
        dateTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        //dateTextField.setDarkTextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: dateTextField.frame.height))
        dateTextField.leftView = paddingView
        dateTextField.leftViewMode = UITextField.ViewMode.always
        
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        dateTextField.text = "\(formatter.string(from: currentDateTime))"
        createDatePicker(picker: datePicker, textField: dateTextField)
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
        
        // dive time textfield
        diveTime.translatesAutoresizingMaskIntoConstraints = false
        diveTime.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20).isActive = true
        diveTime.leadingAnchor.constraint(equalTo: page2.leadingAnchor, constant: 45).isActive = true
        diveTime.heightAnchor.constraint(equalToConstant: 40).isActive = true
        diveTime.trailingAnchor.constraint(equalTo: page2.centerXAnchor, constant: -10).isActive = true
        diveTime.font = UIFont.init(name: "Avenir Next", size: 16)
        diveTime.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        diveTime.layer.cornerRadius = 5
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: diveTime.frame.height))
        diveTime.leftView = paddingView2
        diveTime.leftViewMode = UITextField.ViewMode.always
        //diveTime.setDarkTextField()
        diveTime.keyboardType = UIKeyboardType.decimalPad
        diveTime.attributedPlaceholder = NSAttributedString(string: "0 min",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // maximum depth textfield
        maxDepth.translatesAutoresizingMaskIntoConstraints = false
        maxDepth.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20).isActive = true
        maxDepth.leadingAnchor.constraint(equalTo: page2.centerXAnchor, constant: 10).isActive = true
        maxDepth.heightAnchor.constraint(equalToConstant: 40).isActive = true
        maxDepth.trailingAnchor.constraint(equalTo: page2.trailingAnchor, constant: -45).isActive = true
        maxDepth.font = UIFont.init(name: "Avenir Next", size: 16)
        maxDepth.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        maxDepth.layer.cornerRadius = 5
        let paddingView3 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: maxDepth.frame.height))
        maxDepth.leftView = paddingView3
        maxDepth.leftViewMode = UITextField.ViewMode.always
        maxDepth.keyboardType = UIKeyboardType.decimalPad
        maxDepth.attributedPlaceholder = NSAttributedString(string: "0 m",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func  setupTextfields() {
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        timeDateText = ("\(selectedDate)")
    }
    
    func createDatePicker(picker: UIDatePicker, textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker))
        
        doneButton.tintColor = UIColor(red: 0.07, green: 0.63, blue: 0.93, alpha: 1.00)
        cancelButton.tintColor = UIColor(red: 0.07, green: 0.63, blue: 0.93, alpha: 1.00)
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolbar
        picker.preferredDatePickerStyle = .wheels
        
    }
    
    @objc func doneDatePicker(sender: UITextField!) {
            let formatterDate = DateFormatter()
            formatterDate.dateStyle = .medium
            formatterDate.timeStyle = .short
            dateTextField.text = formatterDate.string(from: datePicker.date)
            dateTextField.resignFirstResponder()
    }
    
    @objc func cancelDatePicker() {
        dateTextField.resignFirstResponder()
    }
    
    func setupNavBar() {
        navBar.barTintColor = .clear
        view.addSubview(navBar)
        view.addSubview(diveNr)
        
        let navItem = UINavigationItem(title: "")
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveButtonActions))
        let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(closeAction))
        saveItem.tintColor = .white
        navItem.rightBarButtonItem = saveItem
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
        
        let gradientLayer = CAGradientLayer()
        var updatedFrame = navBar.bounds
        updatedFrame.size.height += 20
        gradientLayer.frame = updatedFrame
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.0)

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        navBar.setBackgroundImage(image, for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        diveNr.translatesAutoresizingMaskIntoConstraints = false
        diveNr.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        diveNr.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        diveNr.widthAnchor.constraint(equalToConstant: 100).isActive = true
        diveNr.font = UIFont.init(name: "Avenir Light", size: 22)
        diveNr.textAlignment = .center
        diveNr.keyboardType = UIKeyboardType.decimalPad
        diveNr.attributedPlaceholder = NSAttributedString(string: "Nr",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.75)])
    }
    
    func validateFields() -> String? {
        // Check that all fields are filled in
        if  diveNr.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter dive number."
        } else {
            if  Int(diveNr.text!) == nil {
                return "Please enter valid number."
            }
        }
        return nil
    }
    
    func showError(_ message:String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func saveButtonActions() {
        /*let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else {
            let DiveNr = Int(diveNr.text!) ?? 0
            let Location = location.text ?? ""
            let DivePoint = divePoint.text ?? ""
            let Date = dateTextField.text ?? ""
            let DiveTime = diveTime.text ?? ""
            let MaxDepth = maxDepth.text ?? ""
            let Rating = ratingValue.text ?? ""
            let Nitrox = nitrox.text ?? ""
            let Memo = memo.text ?? ""
            
            Firestore.firestore().collection("users").document(uid).collection("DivesCollection").document("\(DiveNr)").setData([
                "DiveNr": DiveNr,
                "Location": Location,
                "DivePoint": DivePoint,
                "Date": Date,
                "DiveTime": DiveTime,
                "MaxDepth": MaxDepth,
                "Rating": Rating,
                "Nitrox": Nitrox,
                "Memo": Memo,
                
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
            for item in buddys {
                
                Firestore.firestore().collection("users").document(uid).collection("DivesCollection").document("\(DiveNr)").collection("Buddy's").document("\(item.Name)" + " \(item.LastName)").setData([
                    "Name": item.Name,
                    "LastName": item.LastName,
                    "Cirtification": item.Cirtification,
                    "Signature": item.signatureData
                    
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
            self.dismiss(animated: true, completion: nil)
        }*/
    }
    
    @objc func closeAction() {
        delegate?.CirtifiedDiveViewController(self)
    }
}

extension CirtifiedDiveViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControll.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
}


class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(absoluteInset: 240, edge: .top, referenceGuide: .superview),
        ]
    }
}
