//
//  BuddyCertificationTableViewCell.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 01/01/2021.
//  Copyright © 2021 Tristan Engelborghs. All rights reserved.
//

import UIKit

class BuddyCertificationTableViewCell: UITableViewCell {

    var indexPatch: NSIndexPath = NSIndexPath()
    var checkboxIndex: NSIndexPath = NSIndexPath()
    
    let completion = UIButton(type: UIButton.ButtonType.custom) as UIButton
    let stackView = UIStackView()
    let topView = UIView()
    let wordLabel = UILabel()
    let signature = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabels()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setupLabels() {

        // configure stack view
        selectionStyle = .none
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.backgroundColor = .systemGray6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(topView)

        // configure top view
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(wordLabel)
        let constraint = topView.heightAnchor.constraint(equalToConstant: 40)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 15).isActive = true
        wordLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        wordLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        wordLabel.text = ""
        wordLabel.numberOfLines = 0
        wordLabel.lineBreakMode = .byWordWrapping
        
        topView.addSubview(signature)
        signature.translatesAutoresizingMaskIntoConstraints = false
        signature.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: 0).isActive = true
        signature.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        signature.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 12)
        signature.setTitle("Add Signature", for: .normal)
        signature.contentEdgeInsets = UIEdgeInsets(top: 3, left: 7, bottom: 3, right: 7)
        signature.layer.borderWidth = 1
        signature.layer.cornerRadius = 5
        signature.titleLabel?.textAlignment = .center
        signature.layer.borderColor = UIColor.systemGray3.cgColor
        signature.isHidden = false
        
        topView.addSubview(completion)
        completion.translatesAutoresizingMaskIntoConstraints = false
        completion.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        completion.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20).isActive = true
        completion.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        completion.tintColor = UIColor(red: 0.07, green: 0.52, blue: 0.63, alpha: 1.00)
        completion.isHidden = true
        
        // height anchors
        topView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        // stackview constraints
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor,constant: 10).isActive = true

    }

}
