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
        imageView.image = UIImage(named: "1.jpg")
        
        return imageView
    }()
    
    private let cardTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "배를 타는 즐거움"
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        
        return label
    }()
    
    let appItemBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    private let appItemStackView: AppItemStackView = {
        let stack = AppItemStackView()
        stack.downloadButton.backgroundColor = .white
        
        return stack
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.addSubview(cardImageView)
        [cardTitleLabel, appItemBaseView].forEach {
            cardImageView.addSubview($0)
        }
        appItemBaseView.addSubview(appItemStackView)
        
        cardImageView.image?.getAverageColor(completion: { [weak self] color in
            self?.cardTitleLabel.textColor = color
        })
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func configureConstraints() {
        cardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(15)
        }
        
        appItemBaseView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        appItemStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
