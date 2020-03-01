//
//  SelectFoodViewController.swift
//  UberTest
//
//  Created by Elizabeth Song on 2/29/20.
//  Copyright © 2020 Elizabeth. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SelectFoodViewController: UIViewController, MKMapViewDelegate {
    var parkplace = ""
    var foodplace: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self

        // Do any additional setup after loading the view.
        
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
        
        request.naturalLanguageQuery = "restaurant"
        
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
    
    @IBOutlet weak var checkButton: UIButton!
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
        foodplace = view.annotation?.title ?? "Confirm"
        checkButton.setTitle("Confirm: \(foodplace!)", for: .normal)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPlan"{
            let planFoodVC = segue.destination as? PlanViewController
            if let foodplace = foodplace {
                planFoodVC?.foodplace = foodplace
                planFoodVC?.parkplace = parkplace
            }
            else{
                let alertController = UIAlertController(title: "error", message:
                "No location selected!", preferredStyle: .alert)

                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
