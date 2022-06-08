//
//  extension.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import UIKit

// UIButton
extension UIButton {
    func setDownloadButton() {
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = 15
        self.setTitleColor(UIColor.systemBlue, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
}

final class Divider: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
