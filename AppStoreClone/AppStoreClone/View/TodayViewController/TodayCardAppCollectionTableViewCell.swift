//
//  TodayCardAppCollectionTableViewCell.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/17.
//

import UIKit

final class TodayCardAppCollectionTableViewCell: UITableViewCell {
    static let identifier = "TodayCardAppCollectionTableViewCell"
    
    // MARK: - View
    private let appItemStackView = AppItemStackView(appItemSize: .large)
    private let divider = Divider()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(appItemStackView)
        contentView.addSubview(divider)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func configureConstraints() {
        appItemStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalToSuperview().offset(-83)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func configure(with appItem: AppModel, index: Int) {
        if (index + 1) % 4 == 1 {
            divider.isHidden = true
        } else {
            divider.isHidden = false
        }
        
        appItemStackView.appIconImageView.image = appItem.iconImage
        
        appItemStackView.appItemTitleLabel.text = appItem.appName
        appItemStackView.appItemDescriptionLabel.text = appItem.appDescription
    }
    
}
