//
//  DateViewModel.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/17.
//

import UIKit

class DateViewModel {
    func getCuttentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 dd일 EEEE"
        dateFormatter.locale = Locale(identifier: "ko_KR")

        return dateFormatter.string(from: Date())
    }
}
