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
    }
    
    func set(dive: DiveInfoStruct) {
        locationLabel.text = dive.location
        dateLabel.text = dive.date
    }
    
    func configureBackgroundView() {
        coloredBackgroundView.clipsToBounds = true
        coloredBackgroundView.image = UIImage(named: "dataCell")
        coloredBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        coloredBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 30).isActive = true
        coloredBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        coloredBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        coloredBackgroundView.widthAnchor.constraint(equalTo: coloredBackgroundView.heightAnchor, multiplier: 10/4).isActive = true
    }
    
    func configureLocationLabel() {
        locationLabel.numberOfLines = 0
        locationLabel.adjustsFontSizeToFitWidth = true
        locationLabel.font = UIFont.init(name: "AvenirNext-Medium", size: 20)
        locationLabel.textAlignment = .right
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalTo: locationLabel.heightAnchor).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: coloredBackgroundView.trailingAnchor, constant: 0).isActive = true
    }
    
    func configureDateLabel() {
        dateLabel.numberOfLines = 0
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        dateLabel.textColor = .gray
    }
}
