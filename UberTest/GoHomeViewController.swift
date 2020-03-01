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
        
        //source location = annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.873700, longitude: -122.271800)
        home.addAnnotation(annotation)
        
        annotation.title = "Ohlone Park"
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        
        //destination location = home
        home.setRegion(region, animated: true)
        
        let apartment = MKPointAnnotation()
        //37.872400, -122.267900
        apartment.coordinate = CLLocationCoordinate2D(latitude: 37.872400, longitude: -122.267900)
        home.addAnnotation(apartment)
        apartment.title = "My Home"
        
        
        let sourcePlaceMark = MKPlacemark(coordinate: annotation.coordinate)
        let destinationPlaceMark = MKPlacemark(coordinate: apartment.coordinate)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request:directionRequest)
        directions.calculate{(response, error) in
            guard let directionResponse = response else {
                if let error = error{
                    print("we have an error")}
                return
            }
            let route = directionResponse.routes[0]
            self.home.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            
            
            
        }
        
        
        
        //populateNearByPlaces()

        // Do any additional setup after loading the view.
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        var color = UIColor(red: 1, green: 89, blue: 169, alpha: 5)
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        
        renderer.lineWidth = 4.0
        return renderer
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
