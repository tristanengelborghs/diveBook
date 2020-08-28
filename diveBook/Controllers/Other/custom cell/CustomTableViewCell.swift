//
//  CustomTableViewCell.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 26/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var coloredBackgroundView = UIImageView()    
    var locationLabel = UILabel()
    var dateLabel = UILabel()
    
    
    
    var grayLine = UIView()
    var grayLine2 = UIView()
    var grayDot = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        
        configureColoredBackgroundView()
        configureGrayLine()
        configureLocationLabel()
        configureDateLabel()
        setViewContstrains()
        setLineConstrains()
        setLabelContstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        //card
        addSubview(coloredBackgroundView)
        
        //labels
        addSubview(locationLabel)
        addSubview(dateLabel)
        
        //gray line
        addSubview(grayLine)
        addSubview(grayLine2)
        addSubview(grayDot)
    }
    
    func set(dive: DiveInfoStruct) {
        locationLabel.text = dive.location
        dateLabel.text = dive.date
        coloredBackgroundView.image = UIImage(named: "blueBackground")
    }
    
    func configureColoredBackgroundView() {
        coloredBackgroundView.clipsToBounds = true
    }
    
    func configureGrayLine() {
        grayLine.clipsToBounds = true
        grayLine2.clipsToBounds = true
        grayDot.clipsToBounds = true
        grayDot.layer.cornerRadius = 4
        
        grayLine.backgroundColor = .lightGray
        grayLine2.backgroundColor = .lightGray
        grayDot.backgroundColor = .lightGray
    }
    
    func configureLocationLabel() {
        locationLabel.numberOfLines = 0
        locationLabel.adjustsFontSizeToFitWidth = true
        locationLabel.font = UIFont.init(name: "Avenir Next", size: 18)
    }
    
    func configureDateLabel() {
        dateLabel.numberOfLines = 0
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        dateLabel.textColor = .gray
    }
    
    func setViewContstrains() {
        coloredBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        coloredBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 45).isActive = true
        coloredBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20 ).isActive = true
        coloredBackgroundView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        coloredBackgroundView.widthAnchor.constraint(equalTo: coloredBackgroundView.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setLineConstrains() {
        grayLine.translatesAutoresizingMaskIntoConstraints = false
        grayLine.topAnchor.constraint(equalTo: topAnchor).isActive = true
        grayLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70 ).isActive = true
        grayLine.heightAnchor.constraint(equalToConstant: 75).isActive = true
        grayLine.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        grayLine2.translatesAutoresizingMaskIntoConstraints = false
        grayLine2.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        grayLine2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70 ).isActive = true
        grayLine2.heightAnchor.constraint(equalToConstant: 75).isActive = true
        grayLine2.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        grayDot.translatesAutoresizingMaskIntoConstraints = false
        grayDot.topAnchor.constraint(equalTo: grayLine.bottomAnchor).isActive = true
        grayDot.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 66).isActive = true
        grayDot.heightAnchor.constraint(equalToConstant: 8).isActive = true
        grayDot.widthAnchor.constraint(equalToConstant: 8).isActive = true
    }
    
    func setLabelContstrains() {
        // location
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.bottomAnchor.constraint(equalTo: coloredBackgroundView.topAnchor, constant: -10).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: coloredBackgroundView.leadingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalTo: locationLabel.heightAnchor).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        //Date
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: grayDot.bottomAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: locationLabel.heightAnchor).isActive = true
    }
}
