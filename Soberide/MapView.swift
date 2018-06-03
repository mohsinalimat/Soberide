//
//  MapView.swift
//  Soberide
//
//  Created by Grant Parton on 5/25/18.
//  Copyright © 2018 Grant Parton. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation

class MapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let house = CLLocationCoordinate2D(latitude: 35.261452, longitude: -120.690960)
    let center = CLLocationCoordinate2D(latitude: 35.278875, longitude: -120.65742)
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let startRegion = MKCoordinateRegion(center: center, span: span)
        map.setRegion(startRegion, animated: true)
        
        //Last seen annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = house
        annotation.title = "Most Recent Location"
        map.addAnnotation(annotation)
        map.delegate = self
    }
    
    //Read func name.
    func configureLocationManager() {
        CLLocationManager.locationServicesEnabled()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = 1.0
        locationManager.distanceFilter = 100.0
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

