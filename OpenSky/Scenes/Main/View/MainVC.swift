//
//  MainVC.swift
//  OpenSky
//
//  Created by İlkay Sever on 17.04.2023.
//

import UIKit
import MapKit

class MainVC: BaseViewController {
    
    // MARK: - UI Components
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var mapTypeView: UIView!
    @IBOutlet weak var zoomInView: UIView!
    @IBOutlet weak var zoomOutView: UIView!
    @IBOutlet weak var myLocationView: UIView!
    @IBOutlet weak var flyCountLabel: UILabel!
    
    // MARK: - Variables
    let viewModel = FlyViewModel()
    
    // MARK: - LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureInitialMap()
        setupBinding()
    }
    
    // MARK: - Functions
    
    // Setup UI Compopnents func.
    private func setupUI() {
        searchTxtField.delegate = self
        searchContainer.addCornerRadius(radius: 8)
        searchContainer.addBorderView(width: 1.5, color: .orange)
        searchContainer.addShadow()
        
        searchTxtField.backgroundColor = .clear
        searchTxtField.borderStyle = .none
        searchTxtField.attributedPlaceholder = NSAttributedString(
            string: "Ülke, Şehir ara...",
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
        
        flyCountLabel.isHidden = true
    }
    
    // MapView configure & User Current Location in Map
    private func configureInitialMap() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        currentLocation()
    }
    
    // Current Location func. from LocationManager
    private func currentLocation() {
        LocationManager.shared.getCurrentLocationData { (location) in
            let coordinate = location.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    // MARK: - Request Functions
    
    private func setupBinding() {
        showLoading()
        DispatchQueue.main.async {
            self.fetchAllFly()
        }
    }
    
    private func fetchAllFly() {
        viewModel.requestAllFly()
        viewModel.didSuccess = {
            if let flyState = self.viewModel.returnFlyState() {
                self.addAirPlaneAnnotation(flyState: flyState)
                self.flyCountLabel.isHidden = false
                self.flyCountLabel.text = "Aktif Uçuşlar: " + "\(self.viewModel.returnFlyStateCount())"
            }
        }
        viewModel.didFailure = { error in
            debugPrint(error)
        }
    }
    
    private func fetchSearchFly(lamin: Double, lomin: Double, lamax: Double, lomax: Double) {
        viewModel.requestSearchFly(lamin: lamin, lomin: lomin, lamax: lamax, lomax: lomax)
        viewModel.didSuccess = {
            if let flyState = self.viewModel.returnFlyState() {
                self.addAirPlaneAnnotation(flyState: flyState)
                self.flyCountLabel.isHidden = false
                self.flyCountLabel.text = "Aktif Uçuşlar: " + "\(self.viewModel.returnFlyStateCount())"
            }
        }
        viewModel.didFailure = { error in
            debugPrint(error)
        }
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
                
                let lamax = lat + 2.0
                let lomax = lon + 2.0
                self.fetchSearchFly(lamin: lat, lomin: lon, lamax: lamax, lomax: lomax)
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let span = MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    private func addAirPlaneAnnotation(flyState: [State]?) {
        flyState?.forEach({ item in
            let lon = CLLocationDegrees(item.longitude ?? 0.0)
            let lat = CLLocationDegrees(item.latitude ?? 0.0)
            let annotation = MKPointAnnotation()
            annotation.title = item.callSign
            annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
            self.mapView.addAnnotation(annotation)
        })
    }
    
    // MARK: - Open Detail Bottom Sheet
    func showDetailSheet() {
        let vc = DetailVC()
        self.presentPanModal(vc)
    }
    
    @IBAction func mapTypeButtonTapped(_ sender: Any) {
        if mapView.mapType == .standard {
            mapView.mapType = .hybrid
        } else {
            mapView.mapType = .standard
        }
    }
    
    @IBAction func zoomInTapped(_ sender: Any) {
        debugPrint("zoom yapıldı...")
    }
    
    @IBAction func zoomOutTapped(_ sender: Any) {
        debugPrint("zoom out yapıldı...")
        showDetailSheet()
    }
    
    @IBAction func myLocationTapped(_ sender: Any) {
        currentLocation()
        fetchAllFly()
    }
    
}

extension MainVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotaionView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotaionView == nil {
            annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotaionView?.canShowCallout = true
        } else {
            annotaionView?.annotation = annotation
        }
        
        annotaionView?.image = UIImage(named: "plane_icon")
        
        return annotaionView
    }
    
}

extension MainVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let textField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            locationRequest(searchText: textField.text?.capitalized ?? "")
            searchTxtField.text = ""
            searchTxtField.text = nil
        }
        return false
    }
    
}
