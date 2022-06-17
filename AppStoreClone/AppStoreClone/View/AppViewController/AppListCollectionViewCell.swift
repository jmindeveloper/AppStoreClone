//
//  AppListCollectionViewCell.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import UIKit
import SnapKit
import SDWebImage

final class AppListCollectionViewCell: UICollectionViewCell {
    static let identifier = "AppListCollectionViewCell"
    
    // MARK: - View
    private let appItemStackView = AppItemStackView(appItemSize: .large)
    
    private let divider = Divider()
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(appItemStackView)
        self.contentView.addSubview(divider)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func configureConstraints() {
        
        appItemStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalToSuperview().offset(-70)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    public func configure(with ranking: Ranking, _ index: Int) {
        if (index + 1) % 3 == 1 {
            divider.isHidden = true
        } else {
            divider.isHidden = false
        }
        
        appItemStackView.appIconImageView.sd_setImage(with: URL(string: ranking.appIconUrlString))
        appItemStackView.appItemTitleLabel.text = ranking.appTitle
        appItemStackView.appItemDescriptionLabel.text = ranking.developerName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        appItemStackView.appIconImageView.image = nil
        appItemStackView.appItemTitleLabel.text = ""
        appItemStackView.appItemDescriptionLabel.text = ""
    }
}
