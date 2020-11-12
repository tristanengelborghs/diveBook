//
//  CustomTableViewCell.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 26/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

let width = UIScreen.main.bounds.size.width - 60

class CustomTableViewCell: UITableViewCell {
    
    var coloredBackgroundView = UIImageView()
    var locationLabel = UILabel()
    var dateLabel = UILabel()
    var DiveNrLabel = UILabel()
    var diveTime = UILabel()
    var startTime = UILabel()
    var depth = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    
        configureBackgroundView()
        configureLocationLabel()
        configureDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(coloredBackgroundView)
        addSubview(locationLabel)
        addSubview(dateLabel)
        addSubview(DiveNrLabel)
        addSubview(diveTime)
        addSubview(startTime)
        addSubview(depth)
    }
    
    func set(dive: DiveInfoStruct) {
        locationLabel.text = dive.location
        dateLabel.text = dive.date
        DiveNrLabel.text = String("\(dive.diveNr)")
        diveTime.text = String("\(dive.diveTime)") + " min"
        startTime.text = dive.startTime
        depth.text = String("\(dive.depth)") + " m"
    }
    
    func configureBackgroundView() {
        coloredBackgroundView.clipsToBounds = false
        coloredBackgroundView.image = UIImage(named: "dataCell")
        coloredBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        coloredBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 30).isActive = true
        coloredBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        coloredBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        coloredBackgroundView.widthAnchor.constraint(equalTo: coloredBackgroundView.heightAnchor, multiplier: 20/7).isActive = true
        coloredBackgroundView.layer.shadowColor = UIColor.black.cgColor
        coloredBackgroundView.layer.shadowOpacity = 0.1
        coloredBackgroundView.layer.shadowOffset = .zero
        coloredBackgroundView.layer.shadowRadius = 5
    }
    
    func configureLocationLabel() {
        locationLabel.numberOfLines = 0
        locationLabel.font = UIFont.init(name: "AvenirNext-Medium", size: 15)
        locationLabel.textAlignment = .right
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalTo: locationLabel.heightAnchor).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: coloredBackgroundView.trailingAnchor, constant: -15).isActive = true
        locationLabel.textColor = .white
        
        DiveNrLabel.numberOfLines = 0
        DiveNrLabel.font = UIFont.init(name: "AvenirNext-Medium", size: 20)
        DiveNrLabel.translatesAutoresizingMaskIntoConstraints = false
        DiveNrLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        DiveNrLabel.leadingAnchor.constraint(equalTo: coloredBackgroundView.leadingAnchor, constant: 15).isActive = true
        DiveNrLabel.heightAnchor.constraint(equalTo: DiveNrLabel.heightAnchor).isActive = true
        DiveNrLabel.trailingAnchor.constraint(equalTo: DiveNrLabel.trailingAnchor).isActive = true
        DiveNrLabel.textColor = .white
        
        diveTime.numberOfLines = 0
        diveTime.textAlignment = .right
        diveTime.font = UIFont.init(name: "Avenir Next", size: 14)
        diveTime.translatesAutoresizingMaskIntoConstraints = false
        diveTime.topAnchor.constraint(equalTo: coloredBackgroundView.topAnchor, constant: self.frame.size.width * 0.18).isActive = true
        diveTime.leadingAnchor.constraint(equalTo: diveTime.leadingAnchor).isActive = true
        diveTime.heightAnchor.constraint(equalTo: diveTime.heightAnchor).isActive = true
        diveTime.trailingAnchor.constraint(equalTo: coloredBackgroundView.trailingAnchor, constant: -15).isActive = true
        diveTime.textColor = .white
        
        startTime.numberOfLines = 0
        startTime.font = UIFont.init(name: "Avenir Next", size: 14)
        startTime.translatesAutoresizingMaskIntoConstraints = false
        startTime.topAnchor.constraint(equalTo: coloredBackgroundView.topAnchor, constant: self.frame.size.width * 0.18).isActive = true
        startTime.leadingAnchor.constraint(equalTo: coloredBackgroundView.leadingAnchor, constant: 15).isActive = true
        startTime.heightAnchor.constraint(equalTo: startTime.heightAnchor).isActive = true
        startTime.trailingAnchor.constraint(equalTo: startTime.trailingAnchor).isActive = true
        startTime.textColor = .white
        
        depth.numberOfLines = 0
        depth.font = UIFont.init(name: "Avenir Next", size: 14)
        depth.translatesAutoresizingMaskIntoConstraints = false
        depth.bottomAnchor.constraint(equalTo: coloredBackgroundView.topAnchor, constant: self.frame.size.width * 0.3).isActive = true
        depth.centerXAnchor.constraint(equalTo: coloredBackgroundView.leadingAnchor, constant: self.frame.size.width * 0.41).isActive = true
        depth.heightAnchor.constraint(equalTo: startTime.heightAnchor).isActive = true
        depth.trailingAnchor.constraint(equalTo: startTime.trailingAnchor).isActive = true
        depth.textColor = .white
    }
    
    func configureDateLabel() {
        dateLabel.font = UIFont.init(name: "Avenir Next", size: 14)
        dateLabel.textAlignment = .right
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: coloredBackgroundView.topAnchor, constant: self.frame.size.width * 0.095).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: dateLabel.heightAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: coloredBackgroundView.trailingAnchor, constant: -15).isActive = true
        dateLabel.textColor = .white
    }
}
