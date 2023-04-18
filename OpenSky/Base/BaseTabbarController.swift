//
//  BaseTabbarController.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    func configureTabBar() {
        view.backgroundColor = AppColors.tabBarColor
        tabBar.backgroundColor = AppColors.tabBarColor
        tabBar.isTranslucent = false
        tabBar.barTintColor = AppColors.tabBarColor
        tabBar.tintColor = AppColors.white
        tabBar.unselectedItemTintColor = UIColor.lightGray
        
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Ubuntu-Medium", size: 10)!], for: .normal)
    }
    
}
