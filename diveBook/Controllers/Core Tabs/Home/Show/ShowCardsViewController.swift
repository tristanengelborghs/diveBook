//
//  ShowCardsViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 03/09/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit

var myIndexCard = CardInfoStruct(Name: "", ID: 0, Organistation: "", Date: "", DiveClub: "")

class ShowCardsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.11, alpha: 1.00)
    // CollectionView variable:
    var collectionView : UICollectionView?
    
    // Variables asociated to collection view:
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
        
    }
    
    func setupLayout(){
        // This is just an utility custom class to calculate screen points
        // to the screen based in a reference view. You can ignore this and write the points manually where is required.
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        
        self.collectionView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.collectionView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.collectionView?.heightAnchor.constraint(equalToConstant: pointEstimator.relativeHeight(multiplier: 1)).isActive = true
        
        self.currentPage = 0
    }
    
    
    func addCollectionView(){
        
        // This is just an utility custom class to calculate screen points
        // to the screen based in a reference view. You can ignore this and write the points manually where is required.
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        
        // This is where the magic is done. With the flow layout the views are set to make costum movements. See https://github.com/ink-spot/UPCarouselFlowLayout for more info
        let layout = UPCarouselFlowLayout()
        // This is used for setting the cell size (size of each view in this case)
        // Here I'm writting 400 points of height and the 73.33% of the height view frame in points.
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.73333), height: 400)
        // Setting the scroll direction
        layout.scrollDirection = .horizontal
        
        // Collection view initialization, the collectionView must be
        // initialized with a layout object.
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // This line if for able programmatic constrains.
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        // CollectionView delegates and dataSource:
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        // Registering the class for the collection view cells
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
        
        cell.customView.backgroundColor = Backgroundcolors[indexPath.row]
        cell.NameLabel.text = colors[indexPath.row].Name
        return cell
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
    let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    
    let NameLabel: UILabel = {
        let Name = UILabel()
        Name.translatesAutoresizingMaskIntoConstraints = false
        Name.textAlignment = .center
        return Name
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.customView)
        self.customView.addSubview(NameLabel)
        
        self.customView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.customView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.customView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        self.customView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        self.NameLabel.centerXAnchor.constraint(equalTo: customView.centerXAnchor).isActive = true
        self.NameLabel.centerYAnchor.constraint(equalTo: customView.centerYAnchor).isActive = true
        self.NameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        self.NameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
