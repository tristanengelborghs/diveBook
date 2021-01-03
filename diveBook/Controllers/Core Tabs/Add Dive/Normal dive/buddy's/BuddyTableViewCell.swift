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
        topView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(topView)
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        // configure top view
        topView.addSubview(wordLabel)
        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 0).isActive = true
        wordLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        wordLabel.font = UIFont.init(name: "Avenir Next", size: 16)
        wordLabel.text = ""
        wordLabel.numberOfLines = 0
        wordLabel.lineBreakMode = .byWordWrapping
        
        //checkbox
        topView.addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        checkButton.frame = CGRect(x: 100, y: 100, width: 22, height: 22)
        checkButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        checkButton.tintColor = .white
        checkButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
        // height anchors

        // stackview constraints
        topView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 0).isActive = true
        topView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: 0).isActive = true
        topView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: 0).isActive = true

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
