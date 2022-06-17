//
//  TodayViewModel.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/16.
//

import UIKit

final class TodayViewModel {
    let appCollection: [AppModel] = [
        AppModel(iconImage: UIImage(named: "1.jpg")!, appName: "배타러갈래?", category: "일상", cost: false, appDescription: "돈 많이 벌게 해줄게"),
        AppModel(iconImage: UIImage(named: "3.jpg")!, appName: "FILTER - Sunset Of Seoul", category: "사진", cost: false, appDescription: "서울의 노을을 담아보세요"),
        AppModel(iconImage: UIImage(named: "1.jpg")!, appName: "배타러갈래?", category: "일상", cost: false, appDescription: "돈 많이 벌게 해줄게"),
        AppModel(iconImage: UIImage(named: "3.jpg")!, appName: "FILTER - Sunset Of Seoul", category: "사진", cost: false, appDescription: "서울의 노을을 담아보세요")
    ]
    
    
    lazy var cards: [TodayCardModel] = [
        TodayCardModel(viewType: CardViewType.appOfTheDay(backgroundImage: UIImage(named: "1.jpg")!, app: AppModel(iconImage: UIImage(named: "1.jpg")!, appName: "배타러갈래?", category: "일상", cost: false, appDescription: "돈 많이 벌게 해줄게"))),
        TodayCardModel(viewType: .appCollection(apps: appCollection, title: "이번주 베스트 상을 확인해보세요", subtitle: "이번주 베스트상")),
        TodayCardModel(viewType: .appArticle(backgroundImage: UIImage(named: "3.jpg")!, title: "서울의 노을을 담아보세요", subtitle: "최고의 사진 필터앱", app: AppModel(iconImage: UIImage(named: "3.jpg")!, appName: "FILTER - Sunset Of Seoul", category: "사진", cost: false, appDescription: "서울의 노을을 담아보세요")))
    ]
}
