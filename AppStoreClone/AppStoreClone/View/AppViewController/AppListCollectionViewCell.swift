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
        imageView.image = UIImage(named: "1.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        
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
        label.text = "배타러갈래?"
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.tintColor = .lightGray
        label.numberOfLines = 1
        // 삭제해야함
        label.text = "돈 많이 벌게 해줄게~~"
        
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setDownloadButton()
        button.setTitle("받기", for: .normal)
        
        return button
    }()
    
    private let divider = Divider()
    
    // MARK: - Properties
    private var appImageFrameWidth: CGFloat {
        appImage.frame.width + 10
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(appImage)
        self.contentView.addSubview(labelStackView)
        self.contentView.addSubview(downloadButton)
        self.contentView.addSubview(divider)
        
        labelStackView.addArrangedSubview(appTitleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        appImage.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().multipliedBy(0.9)
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
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalToSuperview().offset(-70)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
