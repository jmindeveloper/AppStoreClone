//
//  AppListCollectionViewCell.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import UIKit
import SnapKit

final class AppListCollectionViewCell: UICollectionViewCell {
    static let identifier = "AppListCollectionViewCell"
    
    // MARK: - View
    private let appImage: UIImageView = {
        let imageView = UIImageView()
        // 삭제해야함
        imageView.image = UIImage(systemName: "person.fill")
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    private let labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        
        return stack
    }()
    
    private let appTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.tintColor = .label
        label.numberOfLines = 2
        // 삭제해야함
        label.text = "앱 이름"
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.tintColor = .lightGray
        label.numberOfLines = 1
        // 삭제해야함
        label.text = "앱 설명"
        
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setDownloadButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        return button
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(appImage)
        self.contentView.addSubview(labelStackView)
        self.contentView.addSubview(downloadButton)
        
        labelStackView.addArrangedSubview(appTitleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        appImage.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(appImage.snp.height)
        }
        
        labelStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(appImage.snp.trailing).offset(10)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(labelStackView.snp.trailing).offset(-15)
            $0.width.equalTo(65)
            $0.height.equalTo(30)
        }
    }
}
