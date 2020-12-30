//
//  BuddyTableViewCell.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 29/12/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class BuddyTableViewCell: UITableViewCell {
    
    weak var delegate: buddyDelegate?
    var indexPatch: NSIndexPath = NSIndexPath()
    var checkboxIndex: NSIndexPath = NSIndexPath()
    
    let stackView = UIStackView()
    let topView = UIView()
    let wordLabel = UILabel()
    let checkButton = UIButton()
    
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(topView)

        // configure top view
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(wordLabel)
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 0).isActive = true
        wordLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        wordLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        wordLabel.text = ""
        wordLabel.numberOfLines = 0
        wordLabel.lineBreakMode = .byWordWrapping
        
        //checkbox
        stackView.addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        checkButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        checkButton.frame = CGRect(x: 100, y: 100, width: 130, height: 130)
        checkButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        checkButton.tintColor = .white
        checkButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
        // height anchors
        topView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true

        // stackview constraints
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor,constant: 10).isActive = true

    }
    
    @objc func checkboxTapped(sender: UIButton!) {
        checkboxIndex = NSIndexPath(row: sender.tag, section: 0)
        if checkButton.currentBackgroundImage == UIImage(systemName: "checkmark.circle.fill") {
            checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        } else {
            checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        delegate?.checkboxReload(indexPatch: sender)
    }
}
