//
//  ViewController.swift
//  EMS Resources App
//
//  Created by Siddharth on 1/28/22.
//

import UIKit
import MapKit
import SwiftUI

class AmbulanceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D!, title: String!, subtitle: String!) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class ViewController: UIViewController {
    
    var window: UIWindow?
    var mapView: MKMapView?
    var locationManager: CLLocationManager?
    
    let ambulanceCoordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 38.896849, longitude: -77.036683),
        CLLocationCoordinate2D(latitude: 38.947879, longitude: -76.871821),
        CLLocationCoordinate2D(latitude: 38.988609, longitude: -76.944881)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        
        self.mapView = MKMapView(frame: CGRect(
            x: 0,
            y: 0,
            width: (self.window?.frame.width)!,
            height: (self.window?.frame.height)!))
        
        mapView?.delegate = self
        
        mapView?.setRegion(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), // Default to NYC
            latitudinalMeters: 1000,
            longitudinalMeters: 1000), animated: false)
        
        self.view.addSubview(self.mapView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
    }

    func determineCurrentLocation() {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            self.locationManager?.startUpdatingLocation()
            mapView?.showsUserLocation = true
        }
    }
    
    func loadAmbulanceLocations(userCoordinate: CLLocationCoordinate2D!) {
        mapView?.removeAnnotations(mapView!.annotations)
        
        for coords in ambulanceCoordinates {
            var distance: Double = 0
            
            let longitudalDistance = userCoordinate.longitude - coords.longitude
            let latitudalDistance = userCoordinate.latitude - coords.latitude
            let degreeDistance =
            (longitudalDistance * longitudalDistance + latitudalDistance * latitudalDistance).squareRoot()
            distance = degreeDistance * 288200 / 5280 // Convert to feet, then to miles
            
            mapView?.addAnnotation(
                AmbulanceAnnotation(
                    coordinate: coords,
                    title: "Hey :)",
                    subtitle: NSString(format: "%.2f mi", distance) as String))
        }
    }
    
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "ambulance")
        
        return annotationView
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(
            latitude: userLocation.coordinate.latitude,
            longitude: userLocation.coordinate.longitude)

        mapView?.setRegion(
            MKCoordinateRegion(
                center: center,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000), animated: true)
        
        loadAmbulanceLocations(userCoordinate: userLocation.coordinate)
        
        manager.stopUpdatingLocation()
    }
}
