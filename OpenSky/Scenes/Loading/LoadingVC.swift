//
//  LoadingVC.swift
//  iTunesSearch
//
//  Created by İlkay Sever on 23.03.2023.
//

import UIKit
import NVActivityIndicatorView

class LoadingVC: UIViewController {
    
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        startAnimation()
    }
    
    private func configureUI() {
        self.view.backgroundColor = .black
        self.view.alpha = 0.5
        indicator.layer.opacity = 1
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.white
    }
    
    func startAnimation() {
        indicator.startAnimating()
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
    }
    
}
