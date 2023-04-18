//
//  MainVC.swift
//  OpenSky
//
//  Created by İlkay Sever on 17.04.2023.
//

import UIKit
import MapKit
import CoreLocation

enum MapType: Int {
    case standardMap = 0
    case satelliteMap = 1
    case hybridMap = 2
}

class MainVC: BaseViewController {
    
    // MARK: - Varaibles
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var mapTypeView: UIView!
    
    // MARK: - Paris Location
    let coordinate = CLLocationCoordinate2D(latitude: 52.375, longitude: 4.897)
    
    let viewModel = FlyViewModel()
    var mapType: MapType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureMap()
        //setupBinding()
        
    }
    
    private func setupUI() {
        //searchContainer.setCircleView()
        searchContainer.addCornerRadius(radius: 8)
        searchContainer.addBorderView(width: 1.5, color: .orange)
        searchContainer.addShadow()
        
        searchTxtField.backgroundColor = .clear
        searchTxtField.borderStyle = .none
        searchTxtField.attributedPlaceholder = NSAttributedString(
            string: "Uçuş, Şehir, PNR ara...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        mapTypeView.addCornerRadius(radius: 8)
        mapTypeView.addShadow()
    }
    
    private func configureMap() {
        map.delegate = self
        map.mapType = .standard
        map.setRegion(MKCoordinateRegion(center: coordinate,
                                         span: MKCoordinateSpan(latitudeDelta: 0.5,
                                                                longitudeDelta: 0.5)), animated: false)
        addCustomPin()
    }
    
    private func addCustomPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
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
    
    @IBAction func mapTypeButtonTapped(_ sender: Any) {
        switch mapType {
        case .standardMap:
            map.mapType = .standard
        case .satelliteMap:
            map.mapType = .satellite
        case .hybridMap:
            map.mapType = .hybrid
        default:
            break
        }
    }
    
}

extension MainVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotaionView = map.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotaionView == nil {
            annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotaionView?.canShowCallout = true
        } else {
            annotaionView?.annotation = annotation
        }
        
        annotaionView?.image = UIImage(named: "airport_icon")
        
        return annotaionView
    }
    
}
