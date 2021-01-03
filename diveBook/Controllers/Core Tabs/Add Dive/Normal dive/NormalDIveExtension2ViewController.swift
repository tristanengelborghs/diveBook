//
//  NormalDIveExtension2ViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 01/01/2021.
//  Copyright © 2021 Tristan Engelborghs. All rights reserved.
//

import UIKit

extension NormalDiveViewController {

    func BottomTexFields() {
        self.scrollView.addSubview(tableView)
        self.view.backgroundColor = .systemGray6
        setupTableView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
   
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.anchorTableView(top: buddy.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 0, left: 45, bottom: 0, right: 45))
        self.view.updateConstraintsIfNeeded()
        
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        myConstraint.isActive = false
        myConstraint = tableView.heightAnchor.constraint(equalToConstant: CGFloat(buddys.count*40))
        myConstraint.isActive = true
        myConstraint2.isActive = false
        myConstraint2 = saveButton.topAnchor.constraint(equalTo: buddy.bottomAnchor, constant: CGFloat(buddys.count*40) + 60)
        myConstraint2.isActive = true
    }
    
}

extension NormalDiveViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buddys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? BuddyCertificationTableViewCell ?? BuddyCertificationTableViewCell()
        cell.wordLabel.text = "\(buddys[indexPath.row].Name) \(buddys[indexPath.row].LastName)"
        cell.signature.addTarget(self, action: #selector(signatureTapped), for: .touchUpInside)
        
        if senderButton != nil {
            let buttonPosition = senderButton!.convert(CGPoint(), to:tableView)
            let SignatureindexPath = tableView.indexPathForRow(at:buttonPosition)
            
            if SignatureindexPath == indexPath {
                cell.signature.isHidden = true
                cell.completion.isHidden = false
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
        
    @objc func signatureTapped(sender: UIButton!) {
        indexSignature = NSIndexPath(row: sender.tag, section: 0)
        senderButton = sender
        let vc = SignatureViewController()
        self.present(vc, animated: true, completion: {
            vc.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
            
          })
    }

}
