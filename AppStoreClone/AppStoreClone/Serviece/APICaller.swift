//
//  APICaller.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import Foundation
import Combine
import UIKit

enum RankingURL {
    case fetchPaidRanking(String)
    case fetchFreeRanking(String)
    
    var url: URL {
        let baseUrlString = "https://rss.applemarketingtools.com/api/v2/kr/apps"
        switch self {
        case .fetchFreeRanking(let free):
            return URL(string: "\(baseUrlString)/\(free)/50/apps.json")!
        case .fetchPaidRanking(let paid):
            return URL(string: "\(baseUrlString)/\(paid)/50/apps.json")!
        }
    }
}

final class APICaller {
    static let shared = APICaller() // singletone
    
    private init() { }
    
    func fetchPaidRanking() -> AnyPublisher<AppRankingModel, Error> {
        let url = RankingURL.fetchPaidRanking("top-paid").url
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: AppRankingEntity.self, decoder: JSONDecoder())
            .map { AppRankingModel(rankingType: $0.feed.title,
                                   updateDate: $0.feed.updated,
                                   ranking: $0.feed.results)}
            .eraseToAnyPublisher()
    }
    
    func fetchFreeRanking() -> AnyPublisher<AppRankingModel, Error> {
        let url = RankingURL.fetchPaidRanking("top-free").url
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: AppRankingEntity.self, decoder: JSONDecoder())
            .map { AppRankingModel(rankingType: $0.feed.title,
                                   updateDate: $0.feed.updated,
                                   ranking: $0.feed.results)}
            .eraseToAnyPublisher()
    }
    
    func fetchTopRankings() -> AnyPublisher<(AppRankingModel, AppRankingModel), Error> {
        print("fetch...")
        let fetchPaid = fetchPaidRanking()
        let fetchFree = fetchFreeRanking()
        
        return Publishers
            .CombineLatest(fetchPaid, fetchFree)
            .map {
                print("isMainThread: ", Thread.isMainThread)
                return $0
            }
            .eraseToAnyPublisher()
    }
    
    func loadImage(with url: String) -> AnyPublisher<UIImage?, Never> {
        let url = URL(string: url)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: UIImage(systemName: "xmark.octagon")!)
            .eraseToAnyPublisher()
    }
}
