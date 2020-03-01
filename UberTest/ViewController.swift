//
//  ViewController.swift
//  UberTest
//
//  Created by Elizabeth Song on 2/29/20.
//  Copyright © 2020 Elizabeth. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {
    var parkplace: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        
        // Do any additional setup after loading the view.
        
//        let location = CLLocationCoordinate2D(latitude: 40.7539, longitude: 73.9785)
//
//        let regionRadius: CLLocationDistance = 1000.0
//        let region = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
//
//        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.871853, longitude: -122.258423)
        map.addAnnotation(annotation)
        
        annotation.title = "Current Location"
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        map.setRegion(region, animated: true)
        populateNearByPlaces()
        
    }

    @IBOutlet weak var map: MKMapView!
    
    func populateNearByPlaces(){
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = "park"
        
        request.region = map.region
        
        let search = MKLocalSearch(request: request)
        
        search.start{ (response, error) in
            print(response?.mapItems)
            guard let response = response else{
                return
            }
            
            for item in response.mapItems{
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                
                DispatchQueue.main.async{ self.map.addAnnotation(annotation)
                }
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
        parkplace = view.annotation?.title ?? "Confirm"
        confirmButton.setTitle("Confirm: \(parkplace!)", for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFood"{
            let selectFoodVC = segue.destination as? SelectFoodViewController
            if let parkplace = parkplace {
                selectFoodVC?.parkplace = parkplace
            }
            else{
                let alertController = UIAlertController(title: "error", message:
                "No location selected!", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var confirmButton: UIButton!
    
}



