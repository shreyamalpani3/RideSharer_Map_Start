//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            showAlert(title: "Location Services", message: "Location Services are currently disabled. Go to Settings > Privacy > Location Services if you would like to change this.")
        }
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            DispatchQueue.main.async {
                self.mapView.showsUserLocation = true
                self.locationManager.startUpdatingLocation()
            }
        case .denied:
            showAlert(title: "Location Permissions", message: "You have denied location permissions. Go to Settings > Privacy > Location Services if you would like to change this.")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            self.mapView.showsUserLocation = true
        case .restricted:
            showAlert(title: "Location Permissions", message: "Location permission is restricted. Go to Settings > Privacy > Location Services if you would like to change this.")
        default:
            break
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
