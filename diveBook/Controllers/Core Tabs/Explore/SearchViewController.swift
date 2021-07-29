//
//  FloatingPanelViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 15/05/2021.
//  Copyright © 2021 Tristan Engelborghs. All rights reserved.
//

import UIKit
import CoreLocation
import FloatingPanel

protocol SearchViewControllerDelegate: AnyObject {
    func FloatingPanelViewController2(_ vc: SearchViewController)
}

class SearchViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate, CLLocationManagerDelegate {
    
    weak var delegate: SearchViewControllerDelegate?
    let manager = CLLocationManager()
    var tableview = UITableView()
    var divesites: [diveSite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 25
        searchbarSetup()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest // battery
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            let userLatitude = Float(location.coordinate.latitude)
            let userLongtitude = Float(location.coordinate.longitude)
            
            let url = "http://api.divesites.com/?mode=sites&lat=\(userLatitude)&lng=\(userLongtitude)&dist=50"
            FetchData.sharedInstance.getData(from: url, callback: { (Dives) in
                self.divesites = Dives
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            })
        }
    }
    
    func searchbarSetup() {
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 20, width: view.frame.width-20, height: 50))
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Search for dive locations"
        searchBar.isTranslucent = true
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .secondarySystemBackground
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        view.addSubview(searchBar)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.FloatingPanelViewController2(self)
    }
    
    func configureTableView() {
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 100
        tableview.register(SearchCell.self, forCellReuseIdentifier: "Cell")
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return divesites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell") as! SearchCell
        let dive = divesites[indexPath.row]
        cell.titleLabel.text = dive.name
        
        
        return cell
    }
    
    
}
