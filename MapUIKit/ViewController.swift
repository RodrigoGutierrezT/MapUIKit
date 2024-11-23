//
//  ViewController.swift
//  MapUIKit
//
//  Created by Rodrigo on 12-11-24.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    var mapType: MKMapType = .hybrid
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(chooseMapType))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.mapType = mapType
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        
        // check that the annotation is a capital if not, return
        guard annotation is Capital else { return nil }
        
        // set identifier to be used in Reusable Annotation dequeue
        let identifier = "Capital"
        
        // get one annotation view if there is one in the annotation queue, nil otherwise
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        // make annotationView by hand if it doesn't exists
        if annotationView == nil {
            // create Marker Annotation and configure
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // create button and assign it to rightCalloutAccessory
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // Just assign annotation if annotationView already exists
            annotationView?.annotation = annotation
        }
        
        annotationView?.markerTintColor = .green
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
    }
    
    @objc func chooseMapType(sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Map Type", message: "Choose the map type", preferredStyle: .actionSheet)
        
        // create custom actions
        let standardType = UIAlertAction(title: "Standard", style: .default) { [weak self] _ in
            self?.mapType = .standard
            self?.mapView.mapType = .standard
        }
        let hybridType = UIAlertAction(title: "Hybrid", style: .default) { [weak self] _ in
            self?.mapType = .hybrid
            self?.mapView.mapType = .hybrid
        }
        let satelliteType = UIAlertAction(title: "Satellite", style: .default) { [weak self] _ in
            self?.mapType = .satellite
            self?.mapView.mapType = .satellite
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(standardType)
        ac.addAction(hybridType)
        ac.addAction(satelliteType)
        
        present(ac, animated: true)
    }
}

