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
        scrollView.addSubview(timeDate)
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
        
        
        timeDateTitle.translatesAutoresizingMaskIntoConstraints = false
        timeDateTitle.topAnchor.constraint(equalTo: topGradientView.bottomAnchor, constant: 30).isActive = true
        timeDateTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        timeDateTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        timeDateTitle.text = "Date"
        timeDateTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        timeDateTitle.alpha = 0.75
        
        timeDate.translatesAutoresizingMaskIntoConstraints = false
        timeDate.heightAnchor.constraint(equalToConstant: 40).isActive = true
        timeDate.topAnchor.constraint(equalTo: timeDateTitle.bottomAnchor, constant: 10).isActive = true
        timeDate.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        timeDate.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        timeDate.timeZone = NSTimeZone.local
        timeDate.datePickerMode = .date
        timeDate.backgroundColor = .systemGray6
        timeDate.addTarget(self, action: #selector(NormalDiveViewController.datePickerValueChanged(_:)), for: .valueChanged)
        
        
        
        
        
        
        diveInTitle.translatesAutoresizingMaskIntoConstraints = false
        diveInTitle.topAnchor.constraint(equalTo: timeDate.bottomAnchor, constant: 20).isActive = true
        diveInTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        diveInTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        diveInTitle.text = "Time in"
        diveInTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        diveInTitle.alpha = 0.75
        
        diveIn.translatesAutoresizingMaskIntoConstraints = false
        diveIn.topAnchor.constraint(equalTo: diveInTitle.bottomAnchor, constant: 10).isActive = true
        diveIn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        diveIn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        diveIn.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -10).isActive = true
        diveIn.attributedPlaceholder = NSAttributedString(string: "00:00",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        diveIn.font = UIFont.init(name: "Avenir Next", size: 16)
        diveIn.setDarkTextField(textfield: diveIn)
        
        diveTimeTitle.translatesAutoresizingMaskIntoConstraints = false
        diveTimeTitle.topAnchor.constraint(equalTo: timeDate.bottomAnchor, constant: 20).isActive = true
        diveTimeTitle.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10).isActive = true
        diveTimeTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -45).isActive = true
        diveTimeTitle.text = "Dive time"
        diveTimeTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        diveTimeTitle.alpha = 0.75
        
        diveTime.translatesAutoresizingMaskIntoConstraints = false
        diveTime.topAnchor.constraint(equalTo: diveTimeTitle.bottomAnchor, constant: 10).isActive = true
        diveTime.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10).isActive = true
        diveTime.heightAnchor.constraint(equalToConstant: 40).isActive = true
        diveTime.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        diveTime.attributedPlaceholder = NSAttributedString(string: "0 min",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        diveTime.font = UIFont.init(name: "Avenir Next", size: 16)
        diveTime.setDarkTextField(textfield: diveTime)
        
        
        
        
        
        
        
        
        maxDepthTitle.translatesAutoresizingMaskIntoConstraints = false
        maxDepthTitle.topAnchor.constraint(equalTo: diveTime.bottomAnchor, constant: 20).isActive = true
        maxDepthTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        maxDepthTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        maxDepthTitle.text = "Max depth"
        maxDepthTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        maxDepthTitle.alpha = 0.75
        
        maxDepth.translatesAutoresizingMaskIntoConstraints = false
        maxDepth.topAnchor.constraint(equalTo: maxDepthTitle.bottomAnchor, constant: 10).isActive = true
        maxDepth.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        maxDepth.heightAnchor.constraint(equalToConstant: 40).isActive = true
        maxDepth.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -10).isActive = true
        maxDepth.attributedPlaceholder = NSAttributedString(string: "0 m",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        maxDepth.font = UIFont.init(name: "Avenir Next", size: 16)
        maxDepth.setDarkTextField(textfield: maxDepth)
        
        avgDepthTitle.translatesAutoresizingMaskIntoConstraints = false
        avgDepthTitle.topAnchor.constraint(equalTo: diveTime.bottomAnchor, constant: 20).isActive = true
        avgDepthTitle.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10).isActive = true
        avgDepthTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -45).isActive = true
        avgDepthTitle.text = "Avg. depth"
        avgDepthTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        avgDepthTitle.alpha = 0.75
        
        avgDepth.translatesAutoresizingMaskIntoConstraints = false
        avgDepth.topAnchor.constraint(equalTo: avgDepthTitle.bottomAnchor, constant: 10).isActive = true
        avgDepth.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10).isActive = true
        avgDepth.heightAnchor.constraint(equalToConstant: 40).isActive = true
        avgDepth.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        avgDepth.attributedPlaceholder = NSAttributedString(string: "0 m",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        avgDepth.font = UIFont.init(name: "Avenir Next", size: 16)
        avgDepth.setDarkTextField(textfield: avgDepth)
        
        
        
        ratingTitle.translatesAutoresizingMaskIntoConstraints = false
        ratingTitle.topAnchor.constraint(equalTo: maxDepth.bottomAnchor, constant: 20).isActive = true
        ratingTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        ratingTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -45).isActive = true
        ratingTitle.text = "Rating"
        ratingTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        ratingTitle.alpha = 0.75
        
        ratingValue.translatesAutoresizingMaskIntoConstraints = false
        ratingValue.topAnchor.constraint(equalTo: maxDepth.bottomAnchor, constant: 20).isActive = true
        ratingValue.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        ratingValue.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        ratingValue.text = "0 / 100"
        ratingValue.font = UIFont.init(name: "Avenir Next", size: 16)
        ratingValue.alpha = 0.75
        ratingValue.textAlignment = .right
        
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.topAnchor.constraint(equalTo: ratingTitle.bottomAnchor, constant: 20).isActive = true
        rating.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        rating.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        
        rating.minimumValue = 0
        rating.maximumValue = 100
        rating.isContinuous = true
        rating.tintColor = UIColor(red: 0.07, green: 0.45, blue: 0.70, alpha: 1.00)
        rating.addTarget(self, action: #selector(NormalDiveViewController.sliderValueDidChange(_:)), for: .valueChanged)
        
        
        safetyStopTitle.translatesAutoresizingMaskIntoConstraints = false
        safetyStopTitle.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 20).isActive = true
        safetyStopTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        safetyStopTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        safetyStopTitle.text = "Safety Stop"
        safetyStopTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        safetyStopTitle.alpha = 0.75
        
        safetyStop.translatesAutoresizingMaskIntoConstraints = false
        safetyStop.topAnchor.constraint(equalTo: safetyStopTitle.bottomAnchor, constant: 10).isActive = true
        safetyStop.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
        safetyStop.heightAnchor.constraint(equalToConstant: 40).isActive = true
        safetyStop.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        safetyStop.attributedPlaceholder = NSAttributedString(string: "0 m",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        safetyStop.font = UIFont.init(name: "Avenir Next", size: 16)
        safetyStop.setDarkTextField(textfield: safetyStop)
        
        tankVolumeTitle.translatesAutoresizingMaskIntoConstraints = false
        tankVolumeTitle.topAnchor.constraint(equalTo: safetyStop.bottomAnchor, constant: 30).isActive = true
        tankVolumeTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        tankVolumeTitle.text = "Tank Volume"
        tankVolumeTitle.font = UIFont.init(name: "Avenir Next", size: 16)
        tankVolumeTitle.alpha = 0.75
        
        tankVolumeValue.translatesAutoresizingMaskIntoConstraints = false
        tankVolumeValue.topAnchor.constraint(equalTo: safetyStop.bottomAnchor, constant: 30).isActive = true
        tankVolumeValue.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        tankVolumeValue.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        tankVolumeValue.text = "0L"
        tankVolumeValue.font = UIFont.init(name: "Avenir Next", size: 16)
        tankVolumeValue.alpha = 0.75
        tankVolumeValue.textAlignment = .right
        
        tankVolume.translatesAutoresizingMaskIntoConstraints = false
        tankVolume.centerYAnchor.constraint(equalTo: tankVolumeTitle.centerYAnchor).isActive = true
        tankVolume.leadingAnchor.constraint(equalTo: tankVolumeTitle.trailingAnchor, constant: 20).isActive = true
        tankVolume.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -90).isActive = true
        
        tankVolume.minimumValue = 0
        tankVolume.maximumValue = 20
        tankVolume.isContinuous = true
        tankVolume.tintColor = UIColor(red: 0.07, green: 0.45, blue: 0.70, alpha: 1.00)
        tankVolume.addTarget(self, action: #selector(NormalDiveViewController.sliderValueDidChange(_:)), for: .valueChanged)
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
}
