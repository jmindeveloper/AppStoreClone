//
//  AppSingleListCollectionViewCell.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import UIKit

final class AppSingleListCollectionViewCell: UICollectionViewCell {
    static let identifier = "AppSingleListCollectionViewCell"
    
    // MARK: - View
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 진행 중"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SingleListCellColor")
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let appImageView: UIImageView = {
        let imageView = UIImageView()
        // 삭제해야함
        imageView.image = UIImage(named: "1.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let imageTitleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        
        return stack
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "챌린지"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    private let appTitleLargeLabel: UILabel = {
        let label = UILabel()
        label.text = "배는 연안부두에서 타자구"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()
    
    private let appDescriptionLargeLabel: UILabel = {
        let label = UILabel()
        label.text = "좋은배는 파도에 굴복하지 않습니다"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    // MARK: - Properties
    private let appItemStackView = AppItemStackView(appItemSize: .small)
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        contentView.addSubview(baseView)
        contentView.addSubview(headerLabel)
        baseView.addSubview(appImageView)
        baseView.addSubview(appItemStackView)
        appImageView.addSubview(imageTitleStack)
        [categoryLabel, appTitleLargeLabel, appDescriptionLargeLabel].forEach {
            imageTitleStack.addArrangedSubview($0)
        }
        
        appImageView.image?.getAverageColor(completion: { [weak self] color in
            self?.appTitleLargeLabel.textColor = color
            self?.categoryLabel.textColor = color
            self?.appDescriptionLargeLabel.textColor = color
        })
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        headerLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        baseView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(headerLabel.snp.bottom).offset(3)
            $0.height.equalTo(appImageView.snp.height).offset(70)
        }
        
        appImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(appImageView.snp.width).multipliedBy(0.6)
        }
        
        imageTitleStack.snp.makeConstraints {
            $0.leading.equalTo(appItemStackView)
            $0.bottom.equalToSuperview().offset(-15)
        }
        
        appItemStackView.snp.makeConstraints {
            $0.top.equalTo(appImageView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
}
