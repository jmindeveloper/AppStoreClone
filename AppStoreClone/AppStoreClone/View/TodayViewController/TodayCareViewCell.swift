//
//  TodayCareViewCell.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/12.
//

import UIKit
import SnapKit

final class TodayCareViewCell: UICollectionViewCell {
    static let identifier = "TodayCareViewCell"
    
    // MARK: - Properties
    let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardImageView)
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
