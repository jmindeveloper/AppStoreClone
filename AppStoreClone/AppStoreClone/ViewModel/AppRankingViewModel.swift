//
//  AppRankingViewModel.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/09.
//

import Foundation
import Combine

class AppRankingViewModel {
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    @Published var paidRanking: AppRankingModel?
    @Published var freeRanking: AppRankingModel?
    
    let sectionHeader = [
        SectionHeaderModel(title: nil, subTitle: nil, buttonHidden: false),
        SectionHeaderModel(title: "유료 앱 순위", subTitle: nil, buttonHidden: false),
        SectionHeaderModel(title: "무료 앱 순위", subTitle: nil, buttonHidden: false),
        SectionHeaderModel(title: "추천이벤트", subTitle: nil, buttonHidden: true),
        SectionHeaderModel(title: "iPhone 필수 앱", subTitle: "에디터가 엄선한 추천 앱들을 소개합니다", buttonHidden: false),
        SectionHeaderModel(title: "요즘 뜨는 앱", subTitle: "최근 인기 상승이 돋보이는 앱을 확인하세요", buttonHidden: false),
        SectionHeaderModel(title: "놓치지 말아야 할 이벤트", subTitle: nil, buttonHidden: true),
        SectionHeaderModel(title: "크리에이터를 위한 앱", subTitle: nil, buttonHidden: false),
        SectionHeaderModel(title: "하루의 감정을 기록해보세요", subTitle: nil, buttonHidden: true),
        SectionHeaderModel(title: "완벽한 셀카를 위해", subTitle: nil, buttonHidden: false)
    ]
    
    
    // MARK: - Method
    func fetchTopRankings() {
        APICaller.shared.fetchTopRankings()
            .sink { _ in
            } receiveValue: { [weak self] (paid: AppRankingModel, free: AppRankingModel) in
                guard let self = self else { return }
                self.paidRanking = paid
                self.freeRanking = free
            }.store(in: &subscriptions)
    }
}
