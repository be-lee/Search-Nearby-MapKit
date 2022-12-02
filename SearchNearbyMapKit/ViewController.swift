//
//  ViewController.swift
//  SearchNearbyMapKit
//
//  Created by Brendan Lee on 2/12/2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.28, longitude: 114.1588), latitudinalMeters: 200, longitudinalMeters: 200)
        
        getNearbyPlaces()
    }

    func getNearbyPlaces() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "building"
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: { (response, error) in
            guard let response = response else {
                print("Nothing returned")
                return
            }
            
            for item in response.mapItems {
                if let name = item.name, let location = item.placemark.location {
                    print("\(name): \(location.coordinate.latitude), \(location.coordinate.longitude)")
                }
            }
            
        })
    }

}

