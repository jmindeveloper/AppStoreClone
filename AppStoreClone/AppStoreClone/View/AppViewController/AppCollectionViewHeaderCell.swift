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
        imageView.image = UIImage(named: "3.jpg")
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
    
    private lazy var appLargeTitleLabel: UILabel = {
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
    
    private let appItemStackView = AppItemStackView(appItemSize: .small)
    private let divider = Divider()
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
//        appItemStackView.isTextAverageColor = true
        [headerStackView, appImageView, divider].forEach {
            contentView.addSubview($0)
        }
        appImageView.addSubview(appItemStackView)
        [categoryLabel, appLargeTitleLabel, appLargeDescriptionLabel].forEach {
            headerStackView.addArrangedSubview($0)
        }
        configureConstraints()
        
        appImageView.image?.getAverageColor(completion: { [weak self] color in
            self?.appItemStackView.changeLabelColorToAverageColor(color)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func configureConstraints() {
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
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        appItemStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
}
