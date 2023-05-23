//
//  ViewController.swift
//  Project16
//
//  Created by Nicholas on 22/05/2023.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate:
                                CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate:
                            CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info:
                            "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate:
                                CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light")
        let rome = Capital(title: "Rome", coordinate:
                            CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info:
                            "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC",
                                  coordinate:
                                    CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Change", style: .plain, target: self, action: #selector(changeMapType))
        changeMapType()
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Map Type", message: "How would you like to view the map?", preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { _ in
            self.mapView.mapType = .standard
        }))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { _ in
            self.mapView.mapType = .satellite
        }))
        
        present(ac, animated: true)
    }
    
    
}

// MARK: - MKMapViewDelegate

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let indentifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: indentifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: indentifier)
            annotationView?.canShowCallout = true
            annotationView?.markerTintColor = UIColor.blue
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }

        if let webViewController = storyboard?.instantiateViewController(withIdentifier: "Web") as? WebViewController {
            webViewController.city = capital.title
            navigationController?.pushViewController(webViewController, animated: true)
        }
    }
}
