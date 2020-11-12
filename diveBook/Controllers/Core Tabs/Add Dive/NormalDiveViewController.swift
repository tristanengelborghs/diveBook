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

class NormalDiveViewController: UIViewController {
    
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    let contentView = UIView()
    
    let topColor = UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00)
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
        setupScrollView()
        topContainer()
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
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 2000).isActive = true
//        label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30).isActive = true
//        label.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30).isActive = true
//        label.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -30).isActive = true
//
//        label.text = "hello"
//        label.tintColor = .white
    }
    
    func topContainer() {
        let topGradientView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        scrollView.addSubview(topGradientView)
        
        topGradientView.translatesAutoresizingMaskIntoConstraints = false
        topGradientView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topGradientView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        topGradientView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        topGradientView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        
        let gradient = CAGradientLayer()
        gradient.frame = topGradientView.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        topGradientView.layer.insertSublayer(gradient, at: 0)
        
        let arrowButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        scrollView.addSubview(arrowButton)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        arrowButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        arrowButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        arrowButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        arrowButton.imageView?.contentMode = .scaleAspectFit
        arrowButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        arrowButton.tintColor = .white

    }
    
}

