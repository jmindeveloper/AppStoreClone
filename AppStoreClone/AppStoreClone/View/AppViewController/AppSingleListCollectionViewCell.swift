//
//  AppSingleListCollectionViewCell.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import UIKit

final class AppSingleListCollectionViewCell: UICollectionViewCell {
    static let identifier = "AppSingleListCollectionViewCell"
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = [.red, .blue, .orange].randomElement()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
