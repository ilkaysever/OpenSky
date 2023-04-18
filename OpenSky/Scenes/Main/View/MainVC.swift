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
    
    // MARK: - UI Components
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var mapTypeView: UIView!
    @IBOutlet weak var zoomInView: UIView!
    @IBOutlet weak var zoomOutView: UIView!
    @IBOutlet weak var myLocationView: UIView!
    
    // MARK: - Variables
    let coordinate = CLLocationCoordinate2D(latitude: 52.375, longitude: 4.897)
    let viewModel = FlyViewModel()
    var mapType: MapType?
    
    // MARK: - LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureInitialMap()
        //setupBinding()
    }
    
    // MARK: - Functions
    
    // Setup UI Compopnents func.
    private func setupUI() {
        searchTxtField.delegate = self
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
        mapTypeView.addBorderView(width: 1.5, color: .orange)
        mapTypeView.addShadow()
        
        zoomInView.addCornerRadius(radius: 8)
        zoomInView.addBorderView(width: 1.5, color: .orange)
        zoomInView.addShadow()
        
        zoomOutView.addCornerRadius(radius: 8)
        zoomOutView.addBorderView(width: 1.5, color: .orange)
        zoomOutView.addShadow()
        
        myLocationView.addCornerRadius(radius: 8)
        myLocationView.addBorderView(width: 1.5, color: .orange)
        myLocationView.addShadow()
    }
    
    // Map view configure & User Current Location in Map
    private func configureInitialMap() {
        mapView.delegate = self
        mapView.mapType = .standard
//        map.setRegion(MKCoordinateRegion(center: coordinate,
//                                         span: MKCoordinateSpan(latitudeDelta: 0.5,
//                                                                longitudeDelta: 0.5)), animated: false)
//        addCustomPin()
    }
    
    // Add Custom AirPort Pin to map
    private func addCustomPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "Deneme Başlık"
        pin.subtitle = "Deneme Alt Başlık"
        mapView.addAnnotation(pin)
    }
    
    // Request of the searched location
    private func locationRequest(searchText: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { response, error in
            if response == nil {
                debugPrint("error")
            } else {
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                guard let lat = response?.boundingRegion.center.latitude,
                        let lon = response?.boundingRegion.center.longitude else { return }
                
                let annotation = MKPointAnnotation()
                annotation.title = searchText
                annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
                self.mapView.addAnnotation(annotation)
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let span = MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    private func setupBinding() {
        DispatchQueue.main.async {
            self.fetchAllFly()
        }
    }
    
    private func fetchAllFly() {
        viewModel.requestAllFly()
        viewModel.didSuccess = {
            debugPrint(self.viewModel.flyData?.states ?? [[]])
        }
        viewModel.didFailure = { error in
            debugPrint(error)
        }
    }
    
    func showDetailSheet() {
        let vc = DetailVC()
        self.presentPanModal(vc)
    }
    
    @IBAction func mapTypeButtonTapped(_ sender: Any) {
        switch mapType {
        case .standardMap:
            mapView.mapType = .standard
        case .satelliteMap:
            mapView.mapType = .satellite
        case .hybridMap:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
    
    @IBAction func zoomInTapped(_ sender: Any) {
        debugPrint("zoom yapıldı...")
    }
    
    @IBAction func zoomOutTapped(_ sender: Any) {
        debugPrint("zoom out yapıldı...")
    }
    
    @IBAction func myLocationTapped(_ sender: Any) {
        debugPrint("konumumu bul ...")
        showDetailSheet()
    }
    
}

extension MainVC: MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard !(annotation is MKUserLocation) else { return nil }
//
//        var annotaionView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
//        if annotaionView == nil {
//            annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
//            annotaionView?.canShowCallout = true
//        } else {
//            annotaionView?.annotation = annotation
//        }
//
//        annotaionView?.image = UIImage(named: "airport_icon")
//
//        return annotaionView
//    }
    
}

extension MainVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let textField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            locationRequest(searchText: textField.text?.capitalized ?? "")
        }
        return false
    }
    
}
