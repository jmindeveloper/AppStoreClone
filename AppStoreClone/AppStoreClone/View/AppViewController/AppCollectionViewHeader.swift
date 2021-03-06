//
//  AppCollectionViewHeader.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/08.
//

import UIKit
import SnapKit

final class AppCollectionViewHeader: UICollectionReusableView {
    static let identifier = "AppCollectionViewHeader"
    
    // MARK: - Properties
    private let divider = Divider()
    
    let titleAndButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "뱃사람을 위한 앱"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private let headerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "배는 위험합니다. 그만큼 알맞는 앱이 중요하죠"
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleAndButtonStackView)
        addSubview(divider)
        titleAndButtonStackView.addArrangedSubview(labelStackView)
        titleAndButtonStackView.addArrangedSubview(seeMoreButton)
        labelStackView.addArrangedSubview(headerTitleLabel)
        labelStackView.addArrangedSubview(headerDescriptionLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        divider.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        titleAndButtonStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.top.equalTo(divider.snp.bottom).offset(5)
        }
    }
    
    func configure(with model: SectionHeaderModel) {
        if let title = model.title {
            headerTitleLabel.text = title
            titleAndButtonStackView.isHidden = false
        } else {
            titleAndButtonStackView.isHidden = true
        }
        
        if let subTitle = model.subTitle {
            headerDescriptionLabel.isHidden = false
            headerDescriptionLabel.text = subTitle
        } else {
            headerDescriptionLabel.isHidden = true
        }
        
        if model.buttonHidden {
            seeMoreButton.isHidden = true
        } else {
            seeMoreButton.isHidden = false
        }
    }
}
