//
//  BaseTabBarController.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    // MARK: - Method
    private func configureTabBar() {
        let vc1 = TodayViewController()
        let vc2 = UINavigationController(rootViewController: AppViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        
        vc1.tabBarItem.title = "Today"
        vc1.tabBarItem.image = UIImage(systemName: "doc.text.image")
        vc2.tabBarItem.title = "App"
        vc2.tabBarItem.image = UIImage(systemName: "app")
        vc3.tabBarItem.title = "Search"
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        tabBar.tintColor = .label
//        tabBar.barTintColor = .lightGray
        tabBar.isTranslucent = true
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
    
}
