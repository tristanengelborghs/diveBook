//
//  PhotoGalleryViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 24/12/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @objc let addButton = UIButton()
    var photoBack = Data()
    var photoBackString: Data?
    var photoGalleryDataArray: [Data] = photoDataArray
    var myCollectionView: UICollectionView?
    let bottomView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        //self.view.backgroundColor = .systemGray5
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: (view.frame.size.width/3)-2, height: (view.frame.size.width/3)-4)
        myCollectionView = UICollectionView(frame: .init(x: 0, y: 55, width: self.view.frame.width, height: 0.77*self.view.frame.height), collectionViewLayout: flowLayout)
        myCollectionView?.register(CustomPhotoCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView?.backgroundColor = .systemGray6
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
 
        self.view.addSubview(myCollectionView!)
        setupAddButton()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let gradientLayer = CAGradientLayer()
        addButton.layer.masksToBounds = true
        gradientLayer.frame = addButton.bounds
        gradientLayer.colors = [UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00).cgColor,UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00).cgColor ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) // Top left corner.
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        addButton.layer.insertSublayer(gradientLayer, at: 0)
        
        let gradientLayer2 = CAGradientLayer()
        bottomView.layer.masksToBounds = true
        gradientLayer2.frame = bottomView.bounds
        gradientLayer2.colors = [UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00).cgColor,UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00).cgColor ]
        gradientLayer2.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        gradientLayer2.endPoint = CGPoint(x: 1, y: 0)
        bottomView.layer.insertSublayer(gradientLayer2, at: 0)
    }
    
    func setupAddButton() {
        self.view.addSubview(bottomView)
        self.view.addSubview(addButton)
        addButton.anchorButton(top: myCollectionView?.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, trailing: self.view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        bottomView.anchor(top: myCollectionView?.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        addButton.setTitle("Add images", for: .normal)
        addButton.tintColor = .white
        addButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 16)
        addButton.titleLabel?.textAlignment = .left
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
    @objc func addButtonAction(sender: UIButton!) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        
        
        let finalImage = UIImage(data: imageData)
        photoBack = resize(image: finalImage!)!
        photoBackString = photoBack
        photoGalleryDataArray.append(photoBackString!)
        myCollectionView?.reloadData()
    }
    
    @objc func saveVC(sender: UIButton!) {
        if photoDataArray != photoGalleryDataArray {
            if let presenter = presentingViewController as? NormalDiveViewController {
                //photoDataArray.append(contentsOf: photoGalleryDataArray)
                photoDataArray = Array(Set(photoGalleryDataArray))
                presenter.myCollectionView?.reloadData()
            }
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
    
    func resize(image:UIImage) -> Data? {
        if let imageData = image.pngData(){ //if there is an image start the checks and possible compression
       let size = imageData.count / 1024
           if size > 1024 { //if the image data size is > 1024
           let compressionValue = CGFloat(1024 / size) //get the compression value needed in order to bring the image down to 1024
            return image.jpegData(compressionQuality: compressionValue) //return the compressed image data
           }
           else{ //if your image <= 1024 nothing needs to be done and return it as is
             return imageData
           }
       }
       else{ //if it cant get image data return nothing
           return nil
       }
   }
}
extension PhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoGalleryDataArray.count // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomPhotoCell
        let finalImage = UIImage(data: photoGalleryDataArray[indexPath.row])
        cell.image.image = finalImage
        return cell
    }
    
    @objc private func handleButtonTapped() {
        let vc = PhotoGalleryViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
extension PhotoGalleryViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Do you want to delete this picture?", message: "You can always add it back later", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.photoGalleryDataArray = self.photoGalleryDataArray.filter(){$0 != self.photoGalleryDataArray[indexPath.row]}
                    self.myCollectionView?.reloadData()
                
        }))

        self.present(alert, animated: true)
    }
    
}

class CustomPhotoCell: UICollectionViewCell {
    
    var image = UIImageView()
    
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        addSubview(image)
        image.anchorImage(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
