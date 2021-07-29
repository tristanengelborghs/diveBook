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
    let numberView = UIView()
    var locationLabel = UILabel()
    var dateLabel = UILabel()
    var DiveNrLabel = UILabel()
    var diveTime = UILabel()
    var startTime = UILabel()
    var depth = UILabel()
    
    var colors = [UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00), UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00)]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    
        configureBackgroundView()
        configureLocationLabel()
        configureDateLabel()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colors[0].cgColor, colors[1].cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = numberView.bounds
        gradientLayer.cornerRadius = 15

        numberView.backgroundColor = .systemGray5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(numberView)
        addSubview(coloredBackgroundView)
        addSubview(locationLabel)
        addSubview(dateLabel)
        numberView.addSubview(DiveNrLabel)
        addSubview(diveTime)
        addSubview(startTime)
        addSubview(depth)
        
    }
    
    func set(dive: DiveInfoStruct) {
        locationLabel.text = dive.divePoint + ", " + dive.location
        dateLabel.text = dive.date
        DiveNrLabel.text = String("\(dive.diveNr)")
        diveTime.text = dive.depth + " | " + dive.diveTime
        var starting = dive.startTime.replacingOccurrences(of: "AM", with: "am", options: NSString.CompareOptions.literal, range: nil)
        starting = starting.replacingOccurrences(of: "PM", with: "pm", options: NSString.CompareOptions.literal, range: nil)
        startTime.text = ""
        depth.text = ""
    }
    
    func configureBackgroundView() {
        coloredBackgroundView.clipsToBounds = false
        coloredBackgroundView.image = UIImage(named: "dive-graph")
        coloredBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        coloredBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 100).isActive = true
        coloredBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        coloredBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        coloredBackgroundView.widthAnchor.constraint(equalTo: coloredBackgroundView.heightAnchor, multiplier: 3.8/*20/7*/).isActive = true
        coloredBackgroundView.layer.shadowColor = UIColor.black.cgColor
        coloredBackgroundView.layer.shadowOpacity = 0.3
        coloredBackgroundView.layer.shadowOffset = .zero
        coloredBackgroundView.layer.shadowRadius = 10
    }
    
    func configureLocationLabel() {
        numberView.translatesAutoresizingMaskIntoConstraints = false
        numberView.topAnchor.constraint(equalTo: self.topAnchor,constant: 20).isActive = true
        numberView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        numberView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        numberView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        numberView.layer.shadowColor = UIColor.black.cgColor
        numberView.layer.cornerRadius = 10
        numberView.layer.shadowOpacity = 0.3
        numberView.layer.shadowOffset = .zero
        numberView.layer.shadowRadius = 10
        
        locationLabel.numberOfLines = 0
        locationLabel.font = UIFont.init(name: "Avenir Next", size: 15)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: coloredBackgroundView.leadingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalTo: locationLabel.heightAnchor).isActive = true
        //locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        locationLabel.textColor = .white
        
        DiveNrLabel.numberOfLines = 0
        DiveNrLabel.font = UIFont.init(name: "Avenir Next", size: 15)
        DiveNrLabel.translatesAutoresizingMaskIntoConstraints = false
        DiveNrLabel.centerYAnchor.constraint(equalTo: numberView.centerYAnchor).isActive = true
        DiveNrLabel.centerXAnchor.constraint(equalTo: numberView.centerXAnchor).isActive = true
        DiveNrLabel.textColor = .white
        
        diveTime.numberOfLines = 0
        diveTime.textAlignment = .right
        diveTime.font = UIFont.init(name: "Avenir Next", size: 14)
        diveTime.translatesAutoresizingMaskIntoConstraints = false
        diveTime.bottomAnchor.constraint(equalTo: coloredBackgroundView.bottomAnchor).isActive = true
        diveTime.leadingAnchor.constraint(equalTo: diveTime.leadingAnchor).isActive = true
        diveTime.heightAnchor.constraint(equalTo: diveTime.heightAnchor).isActive = true
        diveTime.trailingAnchor.constraint(equalTo: coloredBackgroundView.trailingAnchor).isActive = true
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
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: dateLabel.heightAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: coloredBackgroundView.trailingAnchor).isActive = true
        dateLabel.textColor = .white
    }
}
