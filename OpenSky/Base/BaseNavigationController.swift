//
//  BaseNavigationController.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    static let shared = BaseNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateNavigationBar()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func configurateNavigationBar() {
        let titleStyle: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: AppFonts.UbuntuBold16!]
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = titleStyle
            appearance.shadowColor = .clear
            appearance.backgroundColor = AppColors.backgroundColor
            appearance.setBackIndicatorImage(UIImage(systemName: "arrow.left"), transitionMaskImage: UIImage(systemName: "arrow.left"))
            
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().backgroundColor = AppColors.backgroundColor
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().isTranslucent = false
        }
    }
    
}
