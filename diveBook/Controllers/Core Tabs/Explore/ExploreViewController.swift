//
//  ExploreViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 23/08/2020.
//  Copyright © 2020 Tristan Engelborghs. All rights reserved.
//

import UIKit
import FirebaseAuth
import MapKit
import CoreLocation


class ExploreViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var userLatitude: Float = 0
    var userLongtitude: Float = 0
    var mapView = MKMapView()
    let manager = CLLocationManager()
    var center = CLLocationCoordinate2D()
    var pinLocations = Response(request: nil, sites: nil, version: nil, loc: nil, result: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapviewConstraints()
        mapView.reloadInputViews()
        
        
    }
    
    func mapviewConstraints() {
        view.addSubview(mapView)
        mapView.anchorMap(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
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
            userLatitude = Float(location.coordinate.latitude)
            userLongtitude = Float(location.coordinate.longitude)
            
            let url = "http://api.divesites.com/?mode=sites&lat=\(userLatitude)&lng=\(userLongtitude)&dist=1000"
            getData(from: url)
            mapView.setNeedsLayout()
            mapView.layoutIfNeeded()
            render(location)
            
            
        }
    }
    
    
    
    func render(_ location: CLLocation) {
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        
    }
    
    //API

        
    private func getData(from url: String) {
        
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self]data, response, error in
            
            
            let str = String(decoding: data!, as: UTF8.self)
            print(str)
            let resultString = str.replacingOccurrences(of: "�", with: "")
            let resultData = Data(resultString.utf8)
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: resultData)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            
            pinLocations = Response(request: json.request, sites: json.sites, version: json.version, loc: json.loc, result: json.result)
        
        print(self.pinLocations)
        
        for (divesSites) in self.pinLocations.sites! {
            
            let coordinate = CLLocationCoordinate2D(latitude: Double(divesSites.lat!)!, longitude: Double(divesSites.lng!)!)
            
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            pin.title = divesSites.name
            
            DispatchQueue.main.async {
                        self.mapView.addAnnotation(pin)
            }
            
            print(coordinate)
            
        }
        
        })
        
       task.resume()
    
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil;
        }else{
            let pinIdent = "Pin";
            var pinView: MKPinAnnotationView;
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation;
                pinView = dequeuedView;
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);

            }
            return pinView;
        }
    }
   
}





struct Response: Codable {
    let request: requests?
    let sites: [diveSite]?
    let version: Int?
    let loc: location?
    let result: Bool?
    
}

struct requests: Codable {
    let str: String?
    let timestamp: Int?
    let loc: location?
    let mode: String?
    let dist: String?
    let api: Int?
    
}

struct location: Codable {
    let city: String?
    let area_code: String?
    let postal_code: String?
    let lat: String?
    let region_name: String?
    let country_code: String?
    let name: String?
    let lng: String?
}

struct diveSite: Codable {
    let currents: String?
    let distance: String?
    let hazards: String?
    let lat: String?
    let name: String?
    let water: String?
    let marinelife: String?
    let description: String?
    let maxdepth: String?
    let mindepth: String?
    let predive: String?
    let id: String?
    let equipment: String?
    let lng: String?
}






/*
 {
    "request": {
        "str":null,
        "timestamp":1620902373,
        "loc":{"city":"Hemiksem","area_code":0,"postal_code":"2620","lat":51.1448,"region_name":"Antwerpen","country_code":"BE","name":"Hemiksem, Antwerpen BE","lng":4.33869999999999},
        "mode":"sites",
        "dist":50,
        "api":1
    },
    "sites":
        [
            {"currents":null,"distance":"9.88","hazards":null,"lat":"51.2841","name":"Ekerenput","water":null,"marinelife":null,"description":null,"maxdepth":null,"mindepth":null,"predive":null,"id":"18401","equipment":null,"lng":"4.3904"}
        ],
    "version":1,
    "loc":{
        "city":"Hemiksem",
        "area_code":0,
        "postal_code":"2620",
        "lat":51.1448,
        "region_name":"Antwerpen",
        "country_code":"BE",
        "name":"Hemiksem,
        Antwerpen BE",
        "lng":4.33869999999999
    },
    "result":true
}
 
 */
