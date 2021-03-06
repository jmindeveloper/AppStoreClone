//
//  Cosntant.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/13.
//

import Foundation
import UIKit

var safeAreaInsets: UIEdgeInsets {
    if #available(iOS 15.0, *) {
        let window = UIApplication.shared.connectedScenes
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows.first
        return window!.safeAreaInsets
    } else {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window!.safeAreaInsets
    }
}

var screenFrame: CGRect {
    return UIScreen.main.bounds
}
