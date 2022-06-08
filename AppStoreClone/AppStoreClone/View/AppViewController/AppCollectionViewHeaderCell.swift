//
//  AppCollectionViewHeaderCell.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/08.
//

import UIKit
import SnapKit

final class AppCollectionViewHeaderCell: UICollectionViewCell {
    static let identifier = "AppCollectionViewHeaderCell"
    
    // MARK: - View
    private let appImageView: UIImageView = {
        let imageView = UIImageView()
        // 삭제해야함
        imageView.image = UIImage(named: "1.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        
        return imageView
    }()
    
    private let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        
        return stack
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        // 삭제해야함
        label.text = "APPLE DESIGN AWARDS"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private let appLargeTitleLabel: UILabel = {
        let label = UILabel()
        // 삭제
        label.text = "배타러갈래?"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    private let appLargeDescriptionLabel: UILabel = {
        let label = UILabel()
        // 삭제
        label.text = "돈 많이 벌게 해줄게~~"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGray2
        
        return label
    }()
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let appSmallTitleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let appSmallDescriptionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private let divider = Divider()
    
    // MARK: - Properties
    private var width: CGFloat {
        return contentView.frame.width
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = .red
        [headerStackView, appImageView, divider].forEach {
            contentView.addSubview($0)
        }
        
        [categoryLabel, appLargeTitleLabel, appLargeDescriptionLabel].forEach {
            headerStackView.addArrangedSubview($0)
        }
        
        [appIconImageView, appSmallTitleLabel, appSmallDescriptionLabel, downloadButton].forEach {
            appImageView.addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        divider.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        headerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(divider.snp.bottom).offset(3)
        }
        
        appImageView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(appImageView.snp.width).multipliedBy(0.6)
        }
        
        
    }
}
