//
//  LocationManager.swift
//  OpenSky
//
//  Created by İlkay Sever on 19.04.2023.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private var locationManager: CLLocationManager!
    
    private var completionHandlerForLocationUpdates: ((CLLocation) -> Void)?
    
    private override init() {
        super.init()
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else { return }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Starts updating location
    func startUpdateLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    // Stops updating location
    func stopUpdateLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    // It's called to get current location. Starts location update and stop after getting location
    func getCurrentLocationData(completion: @escaping (CLLocation) -> Void) {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.startUpdateLocation()
                self.completionHandlerForLocationUpdates = { (location) -> Void in
                    completion(location)
                    self.stopUpdateLocation()
                }
            }
        }
    }
    
    // if location changes need to be listened continuously, call this function from outside
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        completionHandlerForLocationUpdates?(location)
    }
    
}
