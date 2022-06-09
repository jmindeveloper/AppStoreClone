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
    
    // MARK: - Method
    func fetchTopRankings() {
        APICaller.shared.fetchTopRankings()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("fetchTopRankingCompletion: ", completion)
            } receiveValue: { [weak self] (paid: AppRankingModel, free: AppRankingModel) in
                guard let self = self else { return }
                print("isMainThread: ", Thread.isMainThread)
                print("paidRankingCout: ", paid.ranking.count)
                print("freeRankingCout: ", free.ranking.count)
                self.paidRanking = paid
                self.freeRanking = free
            }.store(in: &subscriptions)
    }
}
