//
//  PhotoGalleryViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 24/12/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.view.backgroundColor = .systemGray6
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 6
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.width/3)-4)
        let myCollectionView = UICollectionView(frame: .init(x: 0, y: 56, width: self.view.frame.width, height: self.view.frame.height-56), collectionViewLayout: flowLayout)
        myCollectionView.register(CustomPhotoCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.backgroundColor = .systemGray6
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
 
        self.view.addSubview(myCollectionView)
        
    }
    
    func setupNavBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        navBar.isTranslucent = false
        navBar.barTintColor = UIColor.systemGray5
        navBar.shadowImage = UIImage()
        view.addSubview(navBar)
        
        let navItem = UINavigationItem(title: "Add photos")
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveVC))
        let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(closeVC))
        saveItem.tintColor = .white
        
        
        navItem.rightBarButtonItem = saveItem
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func saveVC(sender: UIButton!) {
        if let presenter = presentingViewController as? NormalDiveViewController {
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closeVC(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
        {
            return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        }
}
extension PhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9 // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomPhotoCell
        cell.backgroundColor = .blue
        return cell
    }
}
extension PhotoGalleryViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}

class CustomPhotoCell: UICollectionViewCell {
    
    var image = UIImageView()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
