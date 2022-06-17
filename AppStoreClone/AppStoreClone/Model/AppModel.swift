//
//  AppModel.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/16.
//

import Foundation
import UIKit

class AppModel {
    let iconImage: UIImage
    let appName: String
    let category: String
    let cost: Bool
    let appDescription: String
    
    init(iconImage: UIImage, appName: String, category: String, cost: Bool, appDescription: String) {
        self.iconImage = iconImage
        self.appName = appName
        self.category = category
        self.cost = cost
        self.appDescription = appDescription
    }
}
