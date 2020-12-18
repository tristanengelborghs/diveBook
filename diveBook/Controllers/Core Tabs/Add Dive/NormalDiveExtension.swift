//
//  NormalDiveExtension.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 13/11/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import Foundation
import UIKit

extension NormalDiveViewController {
    
    func middleTexFields() {
        
        scrollView.addSubview(timeDateTitle)
        scrollView.addSubview(maxDepth)
        scrollView.addSubview(maxDepthTitle)
        scrollView.addSubview(avgDepth)
        scrollView.addSubview(avgDepthTitle)
        scrollView.addSubview(diveInTitle)
        scrollView.addSubview(diveIn)
        scrollView.addSubview(diveTime)
        scrollView.addSubview(diveTimeTitle)
        scrollView.addSubview(ratingTitle)
        scrollView.addSubview(rating)
        scrollView.addSubview(ratingValue)
        scrollView.addSubview(safetyStopTitle)
        scrollView.addSubview(safetyStop)
        scrollView.addSubview(tankVolume)
        scrollView.addSubview(tankVolumeTitle)
        scrollView.addSubview(tankVolumeValue)
        scrollView.addSubview(tankAlLabel)
        scrollView.addSubview(tankAlButton)
        scrollView.addSubview(tankSteelLabel)
        scrollView.addSubview(tankSteelButton)
        
        scrollView.addSubview(coloredTankBackground)
        coloredTankBackground.addSubview(bottlePhoto)
        scrollView.addSubview(airInTitle)
        scrollView.addSubview(airIn)
        scrollView.addSubview(barLabel)
        scrollView.addSubview(SAC)
        scrollView.addSubview(SACTitle)
        scrollView.addSubview(barLabel2)
        scrollView.addSubview(airOut)
        scrollView.addSubview(airOutTitle)
        scrollView.addSubview(barLabel3)
        scrollView.addSubview(nitrox)
        scrollView.addSubview(nitroxTitle)
        scrollView.addSubview(barLabel4)
        
        scrollView.addSubview(conditionsTitle)
        scrollView.addSubview(conditions)
        
        // date Title
        timeDateTitle.translatesAutoresizingMaskIntoConstraints = false
        timeDateTitle.topAnchor.constraint(equalTo: topGradientView.bottomAnchor, constant: 30).isActive = true
        timeDateTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        timeDateTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        timeDateTitle.text = "Date"
        timeDateTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        timeDateTitle.alpha = 0.75
        
        // date Textfield
        scrollView.addSubview(dateTextField)
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.topAnchor.constraint(equalTo: timeDateTitle.bottomAnchor, constant: 10).isActive = true
        dateTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        dateTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        dateTextField.bottomAnchor.constraint(equalTo: diveInTitle.topAnchor, constant: -20).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateTextField.font = UIFont.init(name: "Avenir Next", size: 16)
        dateTextField.setDarkTextField(textfield: dateTextField)
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        dateTextField.text = "\(formatter.string(from: currentDateTime))"
        createDatePicker()
        
        // dive time in title
        diveInTitle.translatesAutoresizingMaskIntoConstraints = false
        diveInTitle.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20).isActive = true
        diveInTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        diveInTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        diveInTitle.text = "Time in"
        diveInTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        diveInTitle.alpha = 0.75
        
        // dive time in textfield
        diveIn.translatesAutoresizingMaskIntoConstraints = false
        diveIn.topAnchor.constraint(equalTo: diveInTitle.bottomAnchor, constant: 10).isActive = true
        diveIn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        diveIn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        diveIn.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -10).isActive = true
        diveIn.font = UIFont.init(name: "Avenir Next", size: 16)
        diveIn.setDarkTextField(textfield: diveIn)
        diveIn.attributedPlaceholder = NSAttributedString(string: "00:00",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // dive time title
        diveTimeTitle.translatesAutoresizingMaskIntoConstraints = false
        diveTimeTitle.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20).isActive = true
        diveTimeTitle.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10).isActive = true
        diveTimeTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -45).isActive = true
        diveTimeTitle.text = "Dive time"
        diveTimeTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        diveTimeTitle.alpha = 0.75
        
        // dive time textfield
        diveTime.translatesAutoresizingMaskIntoConstraints = false
        diveTime.topAnchor.constraint(equalTo: diveTimeTitle.bottomAnchor, constant: 10).isActive = true
        diveTime.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10).isActive = true
        diveTime.heightAnchor.constraint(equalToConstant: 40).isActive = true
        diveTime.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        diveTime.font = UIFont.init(name: "Avenir Next", size: 16)
        diveTime.setDarkTextField(textfield: diveTime)
        diveTime.attributedPlaceholder = NSAttributedString(string: "0 min",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // maximum depth title
        maxDepthTitle.translatesAutoresizingMaskIntoConstraints = false
        maxDepthTitle.topAnchor.constraint(equalTo: diveTime.bottomAnchor, constant: 20).isActive = true
        maxDepthTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        maxDepthTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        maxDepthTitle.text = "Max depth"
        maxDepthTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        maxDepthTitle.alpha = 0.75
        
        // maximum depth textfield
        maxDepth.translatesAutoresizingMaskIntoConstraints = false
        maxDepth.topAnchor.constraint(equalTo: maxDepthTitle.bottomAnchor, constant: 10).isActive = true
        maxDepth.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        maxDepth.heightAnchor.constraint(equalToConstant: 40).isActive = true
        maxDepth.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -10).isActive = true
        maxDepth.font = UIFont.init(name: "Avenir Next", size: 16)
        maxDepth.setDarkTextField(textfield: maxDepth)
        maxDepth.attributedPlaceholder = NSAttributedString(string: "0 m",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // avarage depth title
        avgDepthTitle.translatesAutoresizingMaskIntoConstraints = false
        avgDepthTitle.topAnchor.constraint(equalTo: diveTime.bottomAnchor, constant: 20).isActive = true
        avgDepthTitle.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10).isActive = true
        avgDepthTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -45).isActive = true
        avgDepthTitle.text = "Avg. depth"
        avgDepthTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        avgDepthTitle.alpha = 0.75
        
        // avarage depth textfield
        avgDepth.translatesAutoresizingMaskIntoConstraints = false
        avgDepth.topAnchor.constraint(equalTo: avgDepthTitle.bottomAnchor, constant: 10).isActive = true
        avgDepth.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10).isActive = true
        avgDepth.heightAnchor.constraint(equalToConstant: 40).isActive = true
        avgDepth.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        avgDepth.font = UIFont.init(name: "Avenir Next", size: 16)
        avgDepth.setDarkTextField(textfield: avgDepth)
        avgDepth.attributedPlaceholder = NSAttributedString(string: "0 m",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // rating title
        ratingTitle.translatesAutoresizingMaskIntoConstraints = false
        ratingTitle.topAnchor.constraint(equalTo: maxDepth.bottomAnchor, constant: 20).isActive = true
        ratingTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        ratingTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -45).isActive = true
        ratingTitle.text = "Rating"
        ratingTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        ratingTitle.alpha = 0.75
        
        // rating value
        ratingValue.translatesAutoresizingMaskIntoConstraints = false
        ratingValue.topAnchor.constraint(equalTo: maxDepth.bottomAnchor, constant: 20).isActive = true
        ratingValue.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        ratingValue.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        ratingValue.text = "0 / 100"
        ratingValue.font = UIFont.init(name: "Avenir Next", size: 16)
        ratingValue.alpha = 0.75
        ratingValue.textAlignment = .right
        
        // rating slider
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.topAnchor.constraint(equalTo: ratingTitle.bottomAnchor, constant: 20).isActive = true
        rating.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        rating.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        rating.minimumValue = 0
        rating.maximumValue = 100
        rating.isContinuous = true
        rating.tintColor = UIColor(red: 0.07, green: 0.45, blue: 0.70, alpha: 1.00)
        rating.addTarget(self, action: #selector(NormalDiveViewController.sliderValueDidChange(_:)), for: .valueChanged)
        
        // safety stop Title
        safetyStopTitle.translatesAutoresizingMaskIntoConstraints = false
        safetyStopTitle.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 20).isActive = true
        safetyStopTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        safetyStopTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        safetyStopTitle.text = "Safety Stop"
        safetyStopTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        safetyStopTitle.alpha = 0.75
        
        // safety stop textfield
        safetyStop.translatesAutoresizingMaskIntoConstraints = false
        safetyStop.topAnchor.constraint(equalTo: safetyStopTitle.bottomAnchor, constant: 10).isActive = true
        safetyStop.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        safetyStop.heightAnchor.constraint(equalToConstant: 40).isActive = true
        safetyStop.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        safetyStop.font = UIFont.init(name: "Avenir Next", size: 16)
        safetyStop.setDarkTextField(textfield: safetyStop)
        safetyStop.attributedPlaceholder = NSAttributedString(string: "0 m",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // tank volume title
        tankVolumeTitle.translatesAutoresizingMaskIntoConstraints = false
        tankVolumeTitle.topAnchor.constraint(equalTo: safetyStop.bottomAnchor, constant: 30).isActive = true
        tankVolumeTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        tankVolumeTitle.text = "Tank Volume"
        tankVolumeTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        tankVolumeTitle.alpha = 0.75
        
        // tank volume value
        tankVolumeValue.translatesAutoresizingMaskIntoConstraints = false
        tankVolumeValue.topAnchor.constraint(equalTo: safetyStop.bottomAnchor, constant: 30).isActive = true
        tankVolumeValue.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        tankVolumeValue.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        tankVolumeValue.text = "0L"
        tankVolumeValue.font = UIFont.init(name: "Avenir Next", size: 16)
        tankVolumeValue.alpha = 0.75
        tankVolumeValue.textAlignment = .right
        
        // tank volume slider
        tankVolume.translatesAutoresizingMaskIntoConstraints = false
        tankVolume.centerYAnchor.constraint(equalTo: tankVolumeTitle.centerYAnchor).isActive = true
        tankVolume.leadingAnchor.constraint(equalTo: tankVolumeTitle.trailingAnchor, constant: 20).isActive = true
        tankVolume.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -90).isActive = true
        tankVolume.minimumValue = 0
        tankVolume.maximumValue = 20
        tankVolume.isContinuous = true
        tankVolume.tintColor = UIColor(red: 0.07, green: 0.45, blue: 0.70, alpha: 1.00)
        tankVolume.addTarget(self, action: #selector(NormalDiveViewController.sliderValueDidChange(_:)), for: .valueChanged)
        
        // steel tank button
        tankSteelButton.translatesAutoresizingMaskIntoConstraints = false
        tankSteelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        tankSteelButton.topAnchor.constraint(equalTo: tankVolumeTitle.bottomAnchor, constant: 45).isActive = true
        tankSteelButton.frame = CGRect(x: 100, y: 100, width: 130, height: 130)
        tankSteelButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        tankSteelButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        tankSteelButton.setBackgroundImage(SelectedDot, for: .normal)
        tankSteelButton.addTarget(self, action: #selector(tankSteelButtonAction), for: .touchUpInside)
        
        // steel tank label
        tankSteelLabel.translatesAutoresizingMaskIntoConstraints = false
        tankSteelLabel.centerYAnchor.constraint(equalTo: tankSteelButton.centerYAnchor, constant: 0).isActive = true
        tankSteelLabel.leadingAnchor.constraint(equalTo: tankSteelButton.trailingAnchor, constant: 15).isActive = true
        tankSteelLabel.text = "Steel tank"
        tankSteelLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        tankSteelLabel.alpha = 0.75
        
        // alluminium tank button
        tankAlButton.translatesAutoresizingMaskIntoConstraints = false
        tankAlButton.leadingAnchor.constraint(equalTo: tankSteelLabel.trailingAnchor, constant: 30).isActive = true
        tankAlButton.topAnchor.constraint(equalTo: tankVolumeTitle.bottomAnchor, constant: 45).isActive = true
        tankAlButton.frame = CGRect(x: 100, y: 100, width: 130, height: 130)
        tankAlButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        tankAlButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        tankAlButton.setBackgroundImage(UnselectedDot, for: .normal)
        tankAlButton.addTarget(self, action: #selector(tankAllButtonAction), for: .touchUpInside)
        
        // alluminium tank label
        tankAlLabel.translatesAutoresizingMaskIntoConstraints = false
        tankAlLabel.centerYAnchor.constraint(equalTo: tankAlButton.centerYAnchor, constant: 0).isActive = true
        tankAlLabel.leadingAnchor.constraint(equalTo: tankAlButton.trailingAnchor, constant: 15).isActive = true
        tankAlLabel.text = "Aluminium tank"
        tankAlLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        tankAlLabel.alpha = 0.75
        
        // view behind bottle
        coloredTankBackground.translatesAutoresizingMaskIntoConstraints = false
        coloredTankBackground.topAnchor.constraint(equalTo: tankAlLabel.bottomAnchor, constant: 40).isActive = true
        coloredTankBackground.leftAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        coloredTankBackground.heightAnchor.constraint(equalToConstant: 340).isActive = true
        coloredTankBackground.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        let gradient = CAGradientLayer()
        gradient.frame = topGradientView.bounds
        gradient.cornerRadius = 15
        gradient.colors = [bottomColor.cgColor, topColor.cgColor]
        gradient.startPoint = CGPoint(x: -0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.5)
        coloredTankBackground.layer.insertSublayer(gradient, at: 0)
        coloredTankBackground.layer.cornerRadius = 15
        
        // bottle picture
        bottlePhoto.translatesAutoresizingMaskIntoConstraints = false
        bottlePhoto.topAnchor.constraint(equalTo: coloredTankBackground.topAnchor, constant: 10).isActive = true
        bottlePhoto.centerXAnchor.constraint(equalTo: coloredTankBackground.centerXAnchor, constant: 0).isActive = true
        bottlePhoto.heightAnchor.constraint(equalToConstant: 320).isActive = true
        bottlePhoto.image = UIImage(named: "diveBottlePicture")
        bottlePhoto.contentMode = .scaleAspectFit
        
        // air in Title
        airInTitle.translatesAutoresizingMaskIntoConstraints = false
        airInTitle.topAnchor.constraint(equalTo: tankAlLabel.bottomAnchor, constant: 40).isActive = true
        airInTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        airInTitle.trailingAnchor.constraint(equalTo: coloredTankBackground.leadingAnchor, constant: -30).isActive = true
        airInTitle.text = "Air in"
        airInTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        airInTitle.alpha = 0.75
        
        // bar unit text
        barLabel.translatesAutoresizingMaskIntoConstraints = false
        barLabel.centerYAnchor.constraint(equalTo: airIn.centerYAnchor, constant: 0).isActive = true
        barLabel.trailingAnchor.constraint(equalTo: airIn.trailingAnchor, constant: -10).isActive = true
        barLabel.textAlignment = .right
        barLabel.text = "bar"
        barLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        barLabel.alpha = 0.75
        
        // air in textfield
        airIn.translatesAutoresizingMaskIntoConstraints = false
        airIn.topAnchor.constraint(equalTo: airInTitle.bottomAnchor, constant: 10).isActive = true
        airIn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        airIn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        airIn.trailingAnchor.constraint(equalTo: coloredTankBackground.leadingAnchor, constant: -30).isActive = true
        airIn.font = UIFont.init(name: "Avenir Next", size: 16)
        airIn.setDarkTextField(textfield: airIn)
        airIn.attributedPlaceholder = NSAttributedString(string: "200",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        // SAC Title
        SACTitle.translatesAutoresizingMaskIntoConstraints = false
        SACTitle.topAnchor.constraint(equalTo: airIn.bottomAnchor, constant: 10).isActive = true
        SACTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        SACTitle.trailingAnchor.constraint(equalTo: coloredTankBackground.leadingAnchor, constant: -30).isActive = true
        SACTitle.text = "SAC"
        SACTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        SACTitle.alpha = 0.75
        
        // bar unit text
        barLabel2.translatesAutoresizingMaskIntoConstraints = false
        barLabel2.centerYAnchor.constraint(equalTo: SAC.centerYAnchor, constant: 0).isActive = true
        barLabel2.trailingAnchor.constraint(equalTo: SAC.trailingAnchor, constant: -10).isActive = true
        barLabel2.textAlignment = .right
        barLabel2.text = "bar/min"
        barLabel2.font = UIFont.init(name: "Avenir Next", size: 16)
        barLabel2.alpha = 0.75
        
        // SAC textfield
        SAC.translatesAutoresizingMaskIntoConstraints = false
        SAC.topAnchor.constraint(equalTo: SACTitle.bottomAnchor, constant: 10).isActive = true
        SAC.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        SAC.heightAnchor.constraint(equalToConstant: 40).isActive = true
        SAC.trailingAnchor.constraint(equalTo: coloredTankBackground.leadingAnchor, constant: -30).isActive = true
        SAC.font = UIFont.init(name: "Avenir Next", size: 16)
        SAC.setDarkTextField(textfield: SAC)
        SAC.attributedPlaceholder = NSAttributedString(string: "0",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        // air out Title
        airOutTitle.translatesAutoresizingMaskIntoConstraints = false
        airOutTitle.topAnchor.constraint(equalTo: SAC.bottomAnchor, constant: 10).isActive = true
        airOutTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        airOutTitle.trailingAnchor.constraint(equalTo: coloredTankBackground.leadingAnchor, constant: -30).isActive = true
        airOutTitle.text = "Air out"
        airOutTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        airOutTitle.alpha = 0.75
        
        // bar unit text
        barLabel3.translatesAutoresizingMaskIntoConstraints = false
        barLabel3.centerYAnchor.constraint(equalTo: airOut.centerYAnchor, constant: 0).isActive = true
        barLabel3.trailingAnchor.constraint(equalTo: airOut.trailingAnchor, constant: -10).isActive = true
        barLabel3.textAlignment = .right
        barLabel3.text = "bar"
        barLabel3.font = UIFont.init(name: "Avenir Next", size: 16)
        barLabel3.alpha = 0.75
        
        // air out textfield
        airOut.translatesAutoresizingMaskIntoConstraints = false
        airOut.topAnchor.constraint(equalTo: airOutTitle.bottomAnchor, constant: 10).isActive = true
        airOut.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        airOut.heightAnchor.constraint(equalToConstant: 40).isActive = true
        airOut.trailingAnchor.constraint(equalTo: coloredTankBackground.leadingAnchor, constant: -30).isActive = true
        airOut.font = UIFont.init(name: "Avenir Next", size: 16)
        airOut.setDarkTextField(textfield: airOut)
        airOut.attributedPlaceholder = NSAttributedString(string: "50",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        // nitrox Title
        nitroxTitle.translatesAutoresizingMaskIntoConstraints = false
        nitroxTitle.topAnchor.constraint(equalTo: airOut.bottomAnchor, constant: 10).isActive = true
        nitroxTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        nitroxTitle.trailingAnchor.constraint(equalTo: coloredTankBackground.leadingAnchor, constant: -30).isActive = true
        nitroxTitle.text = "Nitrox"
        nitroxTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        nitroxTitle.alpha = 0.75
        
        // nitrox text
        barLabel4.translatesAutoresizingMaskIntoConstraints = false
        barLabel4.centerYAnchor.constraint(equalTo: nitrox.centerYAnchor, constant: 0).isActive = true
        barLabel4.trailingAnchor.constraint(equalTo: nitrox.trailingAnchor, constant: -10).isActive = true
        barLabel4.textAlignment = .right
        barLabel4.text = "%"
        barLabel4.font = UIFont.init(name: "Avenir Next", size: 16)
        barLabel4.alpha = 0.75
        
        // nitrox textfield
        nitrox.translatesAutoresizingMaskIntoConstraints = false
        nitrox.topAnchor.constraint(equalTo: nitroxTitle.bottomAnchor, constant: 10).isActive = true
        nitrox.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        nitrox.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nitrox.trailingAnchor.constraint(equalTo: coloredTankBackground.leadingAnchor, constant: -30).isActive = true
        nitrox.font = UIFont.init(name: "Avenir Next", size: 16)
        nitrox.setDarkTextField(textfield: nitrox)
        nitrox.attributedPlaceholder = NSAttributedString(string: "--",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // Environmental conditions Title
        conditionsTitle.translatesAutoresizingMaskIntoConstraints = false
        conditionsTitle.topAnchor.constraint(equalTo: coloredTankBackground.bottomAnchor, constant: 40).isActive = true
        conditionsTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        conditionsTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        conditionsTitle.text = "Water conditions"
        conditionsTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        conditionsTitle.alpha = 0.75
        
        // Environmental conditions textfield
        conditions.translatesAutoresizingMaskIntoConstraints = false
        conditions.topAnchor.constraint(equalTo: conditionsTitle.bottomAnchor, constant: 10).isActive = true
        conditions.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        conditions.heightAnchor.constraint(equalToConstant: 40).isActive = true
        conditions.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        conditions.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 16)
        conditions.setTitle("--", for: .normal)
        conditions.addTarget(self, action: #selector(conditionsAction), for: .touchUpInside)
        conditions.backgroundColor = .systemGray5
        conditions.layer.cornerRadius = 5
        conditions.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        conditions.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        if (sender == tankVolume) {
            let roundedStepValue = round(sender.value / step) * step
            sender.value = roundedStepValue
            
            tankVolumeValue.text = "\(Int(roundedStepValue))L"
        } else if (sender == rating) {
            // Use this code below only if you want UISlider to snap to values step by step
            let roundedStepValue = round(sender.value / step) * step
            sender.value = roundedStepValue
            
            ratingValue.text = "\(Int(roundedStepValue)) / 100"
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        timeDateText = ("\(selectedDate)")
    }
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))
        
        doneButton.tintColor = UIColor(red: 0.07, green: 0.63, blue: 0.93, alpha: 1.00)
        cancelButton.tintColor = UIColor(red: 0.07, green: 0.63, blue: 0.93, alpha: 1.00)
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
    }
    
    @objc func donePicker() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dateTextField.text = formatter.string(from: datePicker.date)
        dateTextField.resignFirstResponder()
    }
    
    @objc func cancelPicker() {
        dateTextField.resignFirstResponder()
    }
    
    @objc func tankSteelButtonAction() {
        if tankSteelButton.currentBackgroundImage == UnselectedDot {
            tankSteelButton.setBackgroundImage(SelectedDot, for: .normal)
            tankAlButton.setBackgroundImage(UnselectedDot, for: .normal)
        }
    }
    
    @objc func tankAllButtonAction() {
        if tankAlButton.currentBackgroundImage == UnselectedDot {
            tankAlButton.setBackgroundImage(SelectedDot, for: .normal)
            tankSteelButton.setBackgroundImage(UnselectedDot, for: .normal)
        }
    }
    
    @objc func conditionsAction() {
        
        let vc = ConditionsViewController()
        self.present(vc, animated: true, completion: nil)
    }

}
