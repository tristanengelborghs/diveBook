//
//  UISlidingTabController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 25/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

class UISimpleSlidingTabController: UIViewController {
    
    private let collectionHeader = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let collectionPage = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    private let collectionNamePage = UIView.init()
    let image = UIImage(named: "profielFoto.png") as UIImage?
    private let imageButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
    private let arrowButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
    let backgroundColor = UIColor.systemGray6
    private let nameLabel = type(of: UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))).init()
    private let horizontalBar = UIView.init()
    private let collectionHeaderIdentifier = "COLLECTION_HEADER_IDENTIFIER"
    private let collectionPageIdentifier = "COLLECTION_PAGE_IDENTIFIER"
    private var items = [SimpleItemViewControllerOne(), SimpleItemViewControllerTwo()]
    private var titles = [String]()
    private var colorHeaderActive = UIColor.blue
    private var colorHeaderInActive = UIColor.gray
    private var colorHeaderBackground = UIColor.white
    private var currentPosition = 1
    private var tabStyle = SlidingTabStyle.fixed
    private let heightHeader = 57
    var flag = false
   
    
    func viewDidAppear() {
         super.viewWillLayoutSubviews()
         collectionHeader.collectionViewLayout.invalidateLayout()
         collectionPage.collectionViewLayout.invalidateLayout()
         self.collectionPage.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionPage.reloadData()
         
       }
    
    func addItem(item: UIViewController, title: String){
        items.append(item)
        titles.append(title)
    }
    
    func setHeaderBackgroundColor(color: UIColor){
        colorHeaderBackground = color
    }
    
    func setHeaderActiveColor(color: UIColor){
        colorHeaderActive = color
    }
    
    func setHeaderInActiveColor(color: UIColor){
        colorHeaderInActive = color
    }
    
    func setCurrentPosition(position: Int){
        currentPosition = position
        let path = IndexPath(item: position, section: 0)
        print(path)
        
        
        
                DispatchQueue.main.async {
                    self.collectionPage.collectionViewLayout.invalidateLayout()
                    self.collectionPage.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
                    self.collectionPage.reloadData()
                    self.collectionPage.collectionViewLayout.invalidateLayout()
                    self.collectionPage.reloadData()
                }
    }
    
    func setStyle(style: SlidingTabStyle){
        tabStyle = style
    }
    
    func build(){
        view.addSubview(collectionNamePage)
        view.addSubview(collectionHeader)
        view.addSubview(horizontalBar)
        view.addSubview(collectionPage)
            collectionNamePage.addSubview(nameLabel)
            collectionNamePage.addSubview(imageButton)
            collectionNamePage.addSubview(arrowButton)
    
        configureNamePage()
        configureMenuBar()
        configureHorizontalBar()
        configurCollectionPage()
    }
    
    func configureNamePage() {
        let statusBarHeight: CGFloat
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        print(statusBarHeight)
        collectionNamePage.translatesAutoresizingMaskIntoConstraints = false
        collectionNamePage.topAnchor.constraint(equalTo: view.topAnchor, constant: statusBarHeight + 10).isActive = true
        collectionNamePage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        collectionNamePage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionNamePage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionNamePage.backgroundColor = backgroundColor

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: collectionNamePage.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageButton.trailingAnchor, constant: 20).isActive = true
        nameLabel.setTitle("Tristan Engelborghs", for: .normal)
        nameLabel.setTitleColor(.label, for: .normal)
        nameLabel.titleLabel?.font =  UIFont(name: "Avenir Next", size: 16)
        nameLabel.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.centerYAnchor.constraint(equalTo: collectionNamePage.centerYAnchor).isActive = true
        imageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        imageButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageButton.frame = CGRect(x: 100, y: 100, width: 75, height: 75)
        imageButton.setImage(image, for: .normal)
        
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.centerYAnchor.constraint(equalTo: collectionNamePage.centerYAnchor).isActive = true
        arrowButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20).isActive = true
        arrowButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        arrowButton.tintColor = .label
    }
    
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
    }
    
    func configureMenuBar() {
        collectionHeader.translatesAutoresizingMaskIntoConstraints = false
        collectionHeader.topAnchor.constraint(equalTo: collectionNamePage.bottomAnchor).isActive = true
        collectionHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionHeader.heightAnchor.constraint(equalToConstant: CGFloat(heightHeader)).isActive = true
        (collectionHeader.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionHeader.showsHorizontalScrollIndicator = false
        collectionHeader.isScrollEnabled = false
        collectionHeader.backgroundColor = UIColor(red: 0.19, green: 0.44, blue: 0.61, alpha: 1.00)
        collectionHeader.register(HeaderCell.self, forCellWithReuseIdentifier: collectionHeaderIdentifier)
        collectionHeader.delegate = self
        collectionHeader.dataSource = self
        collectionHeader.reloadData()
        collectionHeader.backgroundColor = backgroundColor
       
    }
    
    func configurCollectionPage() {
        collectionPage.translatesAutoresizingMaskIntoConstraints = false
        collectionPage.topAnchor.constraint(equalTo: horizontalBar.bottomAnchor).isActive = true
        collectionPage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionPage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionPage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionPage.backgroundColor = .white
        collectionPage.showsHorizontalScrollIndicator = false
        (collectionPage.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionPage.isPagingEnabled = true
        collectionPage.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionPageIdentifier)
        collectionPage.delegate = self
        collectionPage.dataSource = self
        collectionPage.contentOffset.x = 0
        collectionPage.reloadData()
        collectionPage.backgroundColor = backgroundColor
    }
    
    func configureHorizontalBar() {
        horizontalBar.backgroundColor = UIColor(red: 0.19, green: 0.55, blue: 0.65, alpha: 1.00)
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.layoutSubviews()
        horizontalBarLeftAnchorConstraint = horizontalBar.leftAnchor.constraint(equalTo: view.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBar.bottomAnchor.constraint(equalTo: collectionHeader.bottomAnchor).isActive = true
        horizontalBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        horizontalBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    private class HeaderCell: UICollectionViewCell {
        
        private let label = UILabel()
        private let indicator = UIView()
    
        var text: String! {
            didSet {
                label.text = text
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func select(didSelect: Bool, activeColor: UIColor, inActiveColor: UIColor){
            indicator.backgroundColor = activeColor
            
            if didSelect {
                indicator.isHidden = false
            }else{
                indicator.isHidden = true
            }
        }
        
        private func setupUI(){
            self.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            label.font = UIFont.init(name: "Avenir Next", size: 16)
        }
    }
    
}

extension UISimpleSlidingTabController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if indexPath.row == 0 {
            self.collectionPage.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            } else {
            self.collectionPage.setContentOffset(CGPoint(x: self.collectionPage.frame.width, y: 0), animated: true)
            }
        }
        let x = CGFloat(indexPath.item) * view.frame.width / 2
        horizontalBarLeftAnchorConstraint?.constant = x
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
     sizeForItemAtindexPath: IndexPath) -> CGSize {
          let cellsAcross: CGFloat = 1
          let spaceBetweenCells: CGFloat = 1
             let dim = (self.collectionPage.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
          return CGSize(width: dim, height: self.collectionPage.bounds.height)
    }
   
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionPage {
            //let currentIndex = Int(collectionPage.contentOffset.x / collectionPage.frame.size.width)
            //setCurrentPosition(position: currentIndex)
            
        }
        horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension UISimpleSlidingTabController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionHeader {
            return titles.count
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionHeader {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionHeaderIdentifier, for: indexPath) as! HeaderCell
            cell.text = titles[indexPath.row]
            
            var didSelect = false
            
            if currentPosition == indexPath.row {
                didSelect = true
            }
            
            cell.select(didSelect: didSelect, activeColor: colorHeaderActive, inActiveColor: colorHeaderInActive)
            return cell
        }
        let statusBarHeight: CGFloat
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        var constant: CGFloat = 13
        
        if (statusBarHeight > 21) {
            constant = 25
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionPageIdentifier, for: indexPath)
        let vc = items[indexPath.row]
        
        cell.addSubview(vc.view)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: cell.topAnchor, constant: constant).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        
        return cell
    }
}

extension UISimpleSlidingTabController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionHeader {
            if tabStyle == .fixed {
                let spacer = CGFloat(titles.count)
                return CGSize(width: view.frame.width / spacer, height: CGFloat(heightHeader))
            }else{
                return CGSize(width: view.frame.width * 20 / 100, height: CGFloat(heightHeader))
            }
        }
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionHeader {
            return 10
        }
        
        return 0
    }
}

enum SlidingTabStyle: String {
    case fixed
    case flexible
}

/*extension UICollectionView {
    func scrollTo(indexPath: IndexPath) {
        let attributes = collectionViewLayout.layoutAttributesForItem(at: indexPath)!
        setContentOffset(attributes.frame.origin, animated: true)
    }
}*/
