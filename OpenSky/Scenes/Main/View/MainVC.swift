//
//  MainVC.swift
//  OpenSky
//
//  Created by İlkay Sever on 17.04.2023.
//

import UIKit
import MapKit
import CoreLocation

class MainVC: BaseViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    // MARK: - Paris Location
    let coordinate = CLLocationCoordinate2D(latitude: 48.854, longitude: 2.340)
    
    let viewModel = FlyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        //setupBinding()
        
    }
    
    private func configureMap() {
        map.delegate = self
        map.setRegion(MKCoordinateRegion(center: coordinate,
                                         span: MKCoordinateSpan(latitudeDelta: 0.5,
                                                                longitudeDelta: 0.5)), animated: false)
        addCustomPin()
    }
    
    private func addCustomPin() {
        let pin = MKPointAnnotation()
        pin.title = "Deneme Başlık"
        pin.subtitle = "Deneme Alt Başlık"
        map.addAnnotation(pin)
    }
    
    private func setupBinding() {
        DispatchQueue.main.async {
            self.fetchAllFly()
        }
    }
    
    private func fetchAllFly() {
        viewModel.requestAllFly()
        viewModel.didSuccess = {
            debugPrint(self.viewModel.flyData)
        }
        viewModel.didFailure = { error in
            debugPrint(error)
        }
    }
    
}

extension MainVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotaionView: MKAnnotationView?
        return annotaionView
    }
    
}
