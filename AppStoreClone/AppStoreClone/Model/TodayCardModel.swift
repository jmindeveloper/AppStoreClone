//
//  TodayCardModel.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/15.
//

import Foundation
import UIKit

enum CardViewMode {
    case full
    case card
}

enum CardViewType {
    case appOfTheDay(backgroundImage: UIImage, app: AppModel)
    case appCollection(apps: [AppModel], title: String, subtitle: String)
    case appArticle(backgroundImage: UIImage, title: String, subtitle: String, app: AppModel)
}

class TodayCardModel {
    var viewMode = CardViewMode.card
    let viewType: CardViewType?
    var title: String?
    var subtitle: String?
    var description: String?
    var app: AppModel?
    var appCollection: [AppModel]?
    var backgroundImage: UIImage?
    
    init(viewType: CardViewType) {
        self.viewType = viewType
        switch viewType {
        case .appOfTheDay(let backgroundImage, let app):
            self.backgroundImage = backgroundImage
            self.app = app
        case .appCollection(let apps, let title, let subtitle):
            self.appCollection = apps
            self.title = title
            self.subtitle = subtitle
        case .appArticle(let backgroundImage, let title, let subtitle, let app):
            self.backgroundImage = backgroundImage
            self.title = title
            self.subtitle = subtitle
            self.app = app
        }
    }
}
