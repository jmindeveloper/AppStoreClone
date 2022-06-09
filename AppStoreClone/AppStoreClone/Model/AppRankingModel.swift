//
//  AppRankingModel.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/09.
//

import Foundation

struct AppRankingEntity: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    let id: String
    let author: Author
    let links: [Link]
    let icon: String
    let updated: String
    let copyright: String
    let country: String
    let results: [Ranking]
}

struct Author: Codable {
    let name: String
    let url: String
}

struct Link: Codable {
    let linkSelf: String

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
    }
}

struct Ranking: Codable {
    let developerName: String // 개발자 이름
    let appID: String // app id
    let appTitle: String // app 이름
    let releaseDate: String // app 출시일
    let categories: [Categories] // app 카테고리
    let appStoreUrlString: String // appstoreURL
    let appIconUrlString: String // app icon
    let kind: String

    enum CodingKeys: String, CodingKey {
        case kind
        case developerName = "artistName"
        case appID = "id"
        case appTitle = "name"
        case releaseDate
        case categories = "genres"
        case appStoreUrlString = "url"
        case appIconUrlString = "artworkUrl100"
    }
}

struct Categories: Codable {
    let categoryID: String
    let category: String
    let urlString: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "genreId"
        case category = "name"
        case urlString = "url"
    }
}

struct AppRankingModel {
    let rankingType: String // 랭킹 타입
    let updateDate: String // 랭킹 날짜
    let ranking: [Ranking] // 랭킹목록
}
