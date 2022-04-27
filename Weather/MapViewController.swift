//
//  MapViewController.swift
//  Weather
//
//  Created by Buba on 18.04.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKAnnotation {

    @IBOutlet var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var lat: Double?
    var lon: Double?
    var nameCity: String?
    var weatherEmoji: String?
    var coordinate = CLLocationCoordinate2D (latitude: 0.0, longitude: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupManager()
        upAnatation()
    }
    
    func upAnatation() {

        let anatation = MKPointAnnotation()
        
        guard lat == lat, lon == lon, nameCity == nameCity, weatherEmoji == weatherEmoji else { return }
        anatation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
        anatation.title = nameCity!
        anatation.subtitle = weatherEmoji!
    
        mapView.addAnnotation(anatation)
        
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat!, longitude: lon!), latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }
    
    @IBAction func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    
}
