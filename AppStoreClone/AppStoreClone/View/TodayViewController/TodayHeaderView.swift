//
//  TodayHeaderView.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/17.
//

import UIKit

final class TodayHeaderView: UICollectionReusableView {
    static let identifier = "TodayHeaderView"
    
    // MARK: - View
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = dateViewModel.getCuttentDateString()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "투데이"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    
    // MARK: - Properties
    private let dateViewModel = DateViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [dateLabel, todayLabel, userImageView].forEach {
            addSubview($0)
        }
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview()
        }
        
        todayLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.leading)
            $0.top.equalTo(dateLabel.snp.bottom)
//            $0.bottom.equalToSuperview().offset(5)
        }
        
        userImageView.snp.makeConstraints {
            $0.centerY.equalTo(todayLabel.snp.centerY)
            $0.size.equalTo(30)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
}
