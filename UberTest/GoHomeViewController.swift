//
//  GoHomeViewController.swift
//  UberTest
//
//  Created by Elizabeth Song on 3/1/20.
//  Copyright © 2020 Elizabeth. All rights reserved.
//

import UIKit
import MapKit


class GoHomeViewController: UIViewController, MKMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        home.delegate = self
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.873700, longitude: -122.271800)
        home.addAnnotation(annotation)
        
        annotation.title = "Ohlone Park"
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        
        home.setRegion(region, animated: true)
        populateNearByPlaces()

        // Do any additional setup after loading the view.
    }
    
    func populateNearByPlaces(){
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = "apartment"
        
        request.region = home.region
        
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
                
                DispatchQueue.main.async{ self.home.addAnnotation(annotation)
                }
            }
        }
        
    }
    
   
    
    @IBOutlet weak var home: MKMapView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
