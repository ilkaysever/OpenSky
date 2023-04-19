//
//  BaseViewController.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        navigationItem.backButtonTitle = ""
        view.backgroundColor = AppColors.backgroundColor
        view.alpha = 1.0
    }
    
    func navigationTitle(title: String?) {
        guard let title = title else { return }
        navigationItem.title = title
    }
    
    
}

