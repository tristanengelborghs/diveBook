//
//  ShowCardsViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 03/09/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

var myIndexCard = CardInfoStruct(Name: "", ID: "", Organistation: "", Date: "", DiveClub: "", Instructor: "", Primary: false, PhotoFront: nil  , PhotoBack: nil)

class ShowCardsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectedButtonsArray: [Int] = []
    let Title = UILabel.init()
    let titleDescription = UILabel.init()
    let backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.11, alpha: 1.00)
    var collectionView : UICollectionView?
    var dataPhoto: Data?
    var finalImage: UIImage?
    
    fileprivate var currentPage: Int = 0
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    fileprivate var colors: [CardInfoStruct] = []
    fileprivate var Backgroundcolors: [UIColor] = [UIColor.black, UIColor.red, UIColor.green, UIColor.yellow]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FetchData.sharedInstance.fetchCards(callback: { (Cards) in
            self.colors = Cards
            self.collectionView?.reloadData()
        })
        self.view.backgroundColor = backgroundColor
        self.addCollectionView()
        self.setupLayout()
        self.setTitleLayout()
        setupNavBar()
    }
    
    func setupNavBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.isTranslucent = true
        navBar.backgroundColor = .clear
        navBar.shadowImage = UIImage()
        view.addSubview(navBar)
        
        let navItem = UINavigationItem(title: "")
        let saveItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(saveCard))
        let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(closeVC))
        saveItem.tintColor = .white
        
        navItem.rightBarButtonItem = saveItem
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func saveCard(sender: UIButton!) {
        let vc = AddCardViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func closeVC(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    func setTitleLayout() {
        let height = self.view.frame.height
        let width = self.view.frame.width
        let middle = (height - 400)/4
        let heightTitle = Utilities.requiredHeight(font:"Avenir Next Bold", labelText: "Dive Certifications", size: 25.0)
        let heightTitleDescription = Utilities.requiredHeight(font: "Avenir Next", labelText: "Save your dive cards", size: 14.0)
        let textHeight = (heightTitle + heightTitleDescription - 10)/2
        self.view.addSubview(Title)
        self.view.addSubview(titleDescription)
        self.Title.translatesAutoresizingMaskIntoConstraints = false
        self.Title.text = "Dive Certifications"
        self.Title.font = UIFont.init(name: "Avenir Next Bold", size: 25)
        self.Title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: middle - textHeight).isActive = true
        self.Title.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.titleDescription.translatesAutoresizingMaskIntoConstraints = false
        self.titleDescription.text = "Save your dive cards here so you can acces them anywhere"
        self.titleDescription.font = UIFont.init(name: "Avenir Next", size: 14)
        self.titleDescription.topAnchor.constraint(equalTo: self.Title.bottomAnchor, constant: 5).isActive = true
        self.titleDescription.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleDescription.widthAnchor.constraint(equalToConstant: width / 1.5).isActive = true
        self.titleDescription.numberOfLines = 0
        self.titleDescription.textAlignment = .center
        
    }
    func setupLayout(){
        
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        
        self.collectionView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.collectionView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.collectionView?.heightAnchor.constraint(equalToConstant: pointEstimator.relativeHeight(multiplier: 1)).isActive = true
        
        self.currentPage = 0
    }
    
    func addCollectionView(){
        
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.73333), height: 400)
        layout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.register(CardCell.self, forCellWithReuseIdentifier: "cellId")
        
        // Spacing between cells:
        let spacingLayout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 20)
        
        self.collectionView?.backgroundColor = backgroundColor
        self.view.addSubview(self.collectionView!)
        
    }
    
    // MARK: - Card Collection Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CardCell
        
        cell.cardTitle.text = colors[indexPath.row].Organistation + " " + colors[indexPath.row].Name
        cell.dateLabel.text = colors[indexPath.row].Date
        cell.idLabel.text = String(colors[indexPath.row].ID)
        cell.photoBackButton.setTitle("", for: .normal)
        cell.photoView.backgroundColor = .clear
        cell.photoView.image = nil
        cell.photoView.backgroundColor = .clear
        cell.photoBackButton.setTitle("", for: .normal)
        
        
        if (colors[indexPath.row].Instructor != "") {
            cell.diveClubTitle.text = "Certified By"
            cell.instructorLabel.text = colors[indexPath.row].Instructor
            cell.diveClubLabel.text = colors[indexPath.row].DiveClub
        } else if (colors[indexPath.row].DiveClub != "") {
            cell.diveClubTitle.text = "Certified By"
            cell.instructorLabel.text = colors[indexPath.row].DiveClub
            cell.diveClubLabel.text = ""
        } else {
            cell.diveClubTitle.text = ""
            cell.instructorLabel.text = ""
            cell.diveClubLabel.text = ""
        }
        
        if (colors[indexPath.row].Primary == true) {
            cell.primaryLabel.setTitle("Primary", for: .normal)
            cell.primaryLabel.layer.borderWidth = 1
        } else {
            cell.primaryLabel.setTitle("", for: .normal)
            cell.primaryLabel.layer.borderWidth = 0
        }
        
        if (colors[indexPath.row].PhotoFront != nil) {
            cell.finalImage = UIImage(data: colors[indexPath.row].PhotoFront!)!
        } else {
            cell.finalImage = nil
        }
        
        if (cell.finalImage != nil) {
            cell.customView.addSubview(cell.photoButton)
            cell.photoButton.translatesAutoresizingMaskIntoConstraints = false
            cell.photoButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -30).isActive = true
            cell.photoButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -30).isActive = true
            cell.photoButton.setTitle("view photo", for: .normal)
            cell.photoButton.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 14)
            cell.photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
            
            cell.customView.addSubview(cell.photoBackButton)
            cell.photoBackButton.translatesAutoresizingMaskIntoConstraints = false
            cell.photoBackButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -30).isActive = true
            cell.photoBackButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -30).isActive = true
            cell.photoBackButton.setTitle("", for: .normal)
            cell.photoBackButton.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 14)
            cell.photoBackButton.addTarget(self, action: #selector(hideButtonTapped), for: .touchUpInside)
            cell.photoBackButton.isHidden = true
        }
        cell.photoButton.tag = indexPath.row
        
        
        cell.reloadInputViews()
        
        
        return cell
    }
    
    @objc func photoButtonTapped(_ sender: UIButton){
        let sen: UIButton = sender
        let g : NSIndexPath = NSIndexPath(row: sen.tag, section: 0)
        let t : CardCell = self.collectionView?.cellForItem(at: g as IndexPath) as! CardCell
        t.photoButton.setTitle("", for: .normal)
        t.photoView.clipsToBounds = true;
        t.photoView.image = t.finalImage
        t.photoView.backgroundColor = .systemGray6
        t.photoBackButton.isHidden = false
        t.photoBackButton.setTitle("hide photo", for: .normal)
    }
    
    @objc func hideButtonTapped(_ sender: UIButton){
        self.collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myIndexCard = colors[indexPath.row]
        
        let vc = ShowCardInfoViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    
}

class CardCell: UICollectionViewCell {
    
    var yourobj : (() -> Void)? = nil

    var finalImage: UIImage? = nil
    let photoView = UIImageView()
    let gradientLayer = CAGradientLayer()
    let cardTitle = UILabel()
    let dateLabel = UILabel()
    let idLabel = UILabel()
    let diveClubTitle = UILabel()
    let instructorLabel = UILabel()
    let diveClubLabel = UILabel()
    let editButton = UIButton()
    let photoButton = UIButton()
    let photoBackButton = UIButton()
    let primaryLabel = UIButton()
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        gradientLayer.frame = customView.bounds
        
        let colorSet = [UIColor(red: 0.07, green: 0.63, blue: 0.63, alpha: 1.00),
                        UIColor(red: 0.07, green: 0.25, blue: 0.57, alpha: 1.00)]
        let location = [0.2, 1.0]
        
        customView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    
    let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(self.customView)
        
        customView.addSubview(self.cardTitle)
        customView.addSubview(dateLabel)
        customView.addSubview(idLabel)
        customView.addSubview(diveClubTitle)
        customView.addSubview(instructorLabel)
        customView.addSubview(diveClubLabel)
        customView.addSubview(editButton)
        customView.addSubview(primaryLabel)
        customView.addSubview(photoView)
        
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.topAnchor.constraint(equalTo: customView.topAnchor).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        photoView.leadingAnchor.constraint(equalTo: customView.leadingAnchor).isActive = true
        photoView.trailingAnchor.constraint(equalTo: customView.trailingAnchor).isActive = true
        photoView.contentMode = .scaleAspectFit
        photoView.clipsToBounds = true;
        
        customView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        customView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        customView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        customView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        cardTitle.leadingAnchor.constraint(equalTo: self.customView.leadingAnchor, constant: 30).isActive = true
        cardTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        cardTitle.widthAnchor.constraint(equalTo: self.customView.widthAnchor, multiplier: 0.75).isActive = true
        cardTitle.font = UIFont.init(name: "Avenir Next Bold", size: 20)
        cardTitle.numberOfLines = 0
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 30).isActive = true
        dateLabel.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 5).isActive = true
        dateLabel.font = UIFont.init(name: "Avenir Next", size: 14)
        dateLabel.numberOfLines = 0
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 30).isActive = true
        idLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
        idLabel.font = UIFont.init(name: "Avenir Next", size: 14)
        idLabel.numberOfLines = 0
        
        diveClubTitle.translatesAutoresizingMaskIntoConstraints = false
        diveClubTitle.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 30).isActive = true
        diveClubTitle.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 30).isActive = true
        diveClubTitle.font = UIFont.init(name: "Avenir Next Bold", size: 14)
        diveClubTitle.numberOfLines = 0
        
        instructorLabel.translatesAutoresizingMaskIntoConstraints = false
        instructorLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 30).isActive = true
        instructorLabel.topAnchor.constraint(equalTo: diveClubTitle.bottomAnchor, constant: 5).isActive = true
        instructorLabel.font = UIFont.init(name: "Avenir Next", size: 14)
        instructorLabel.numberOfLines = 0
        
        diveClubLabel.translatesAutoresizingMaskIntoConstraints = false
        diveClubLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 30).isActive = true
        diveClubLabel.topAnchor.constraint(equalTo: instructorLabel.bottomAnchor, constant: 5).isActive = true
        diveClubLabel.font = UIFont.init(name: "Avenir Next", size: 14)
        diveClubLabel.numberOfLines = 0
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        editButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        editButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        editButton.tintColor = .white
        
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        primaryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        primaryLabel.contentEdgeInsets = UIEdgeInsets(top: 3,left: 8,bottom: 3,right: 8)
        primaryLabel.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 14)
        primaryLabel.layer.cornerRadius = 3
        primaryLabel.layer.borderColor = UIColor.white.cgColor
        
    }
    
    @objc func photoButtonTapped(_ sender: UIButton){
        //photoView.image = finalImage
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func connected(sender: UIButton){
        if let btnAction = self.yourobj
        {
            btnAction()
        }
    }
    
    
} // End of CardCell

class RelativeLayoutUtilityClass {
    
    var heightFrame: CGFloat?
    var widthFrame: CGFloat?
    
    init(referenceFrameSize: CGSize){
        heightFrame = referenceFrameSize.height
        widthFrame = referenceFrameSize.width
    }
    
    func relativeHeight(multiplier: CGFloat) -> CGFloat{
        
        return multiplier * self.heightFrame!
    }
    
    func relativeWidth(multiplier: CGFloat) -> CGFloat{
        return multiplier * self.widthFrame!
        
    }
    
    
    
}

extension UIView {
    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero
        
        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }
        
        layer.colors = layerColorSet
        layer.locations = layerLocations
        layer.cornerRadius = 12
        
        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }
        
        self.layer.insertSublayer(layer, at: 0)
    }
}
