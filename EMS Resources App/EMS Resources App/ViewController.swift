//
//  ViewController.swift
//  EMS Resources App
//
//  Created by Siddharth on 1/28/22.
//

import UIKit
import MapKit

class AmbulanceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D!) {
        self.coordinate = coordinate
        self.title = "Title"
        self.subtitle = "Subtitle"
    }
}

class ViewController: UIViewController {
    
    var window: UIWindow?
    var mapView: MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
            
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        
        self.mapView = MKMapView(frame: CGRect(
            x: 0,
            y: 0,
            width: (self.window?.frame.width)!,
            height: (self.window?.frame.height)!))
        
        mapView?.delegate = self
        
        mapView?.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.992035, longitude: -76.945404), latitudinalMeters: 1000, longitudinalMeters: 1000), animated: false)
        
        self.view.addSubview(self.mapView!)
        
        let coords = CLLocationCoordinate2D(latitude: 38.992035, longitude: -76.945404)
        
        //let ambulance = AmbulanceAnnotation(coordinate: coords)
        let ambulance = MKPointAnnotation()
        ambulance.coordinate = coords
        
        mapView?.addAnnotation(ambulance)
    }


}

extension ViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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

