//
//  AppItemStackView.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/08.
//

import UIKit
import SnapKit

enum AppItemSize {
    case small
    case large
}

final class AppItemStackView: UIView {
    
    private let appItemSize: AppItemSize
    
    // MARK: - View
    let appItemStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 7
        
        return stack
    }()
    
    lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1.jpg")
        imageView.layer.cornerRadius = appItemSize == .small ? 5 : 10
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var appItemTitleAndDescriptionStaciView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = appItemSize == .small ? 0 : 5
        
        return stack
    }()
    
    lazy var appItemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "배타러갈래?"
        label.font = appItemSize == .small ?
        UIFont.systemFont(ofSize: 15, weight: .semibold) :
        UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 2
        label.textColor = .label
        
        return label
    }()
    
    lazy var appItemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "돈 많이 벌게 해줄게~~"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textColor = .label
        
        return label
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setDownloadButton()
        button.setTitle("받기", for: .normal)
        
        return button
    }()
    
    init(appItemSize: AppItemSize) {
        self.appItemSize = appItemSize
        super.init(frame: .zero)
        configureStack()
        
        switch appItemSize {
        case .small:
            configureSmallCostraints()
        case .large:
            configureLargeCostraints()
        }
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStack() {
        
        [appIconImageView, appItemTitleAndDescriptionStaciView, downloadButton].forEach {
            appItemStackView.addArrangedSubview($0)
        }
        appItemTitleAndDescriptionStaciView.addArrangedSubview(appItemTitleLabel)
        appItemTitleAndDescriptionStaciView.addArrangedSubview(appItemDescriptionLabel)
        self.addSubview(appItemStackView)
        
        
    }
    
    private func configureSmallCostraints() {
        appItemStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        appIconImageView.snp.makeConstraints {
            $0.width.height.equalTo(35)
        }
        
        downloadButton.snp.makeConstraints {
            $0.width.equalTo(65)
            $0.height.equalTo(30)
        }
    }
    
    private func configureLargeCostraints() {
        appItemStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        appIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(appIconImageView.snp.height)
        }
        
        downloadButton.snp.makeConstraints {
            $0.width.equalTo(65)
            $0.height.equalTo(30)
        }
    }
    
    func changeLabelColorToAverageColor(_ color: UIColor) {
        appItemTitleLabel.textColor = color
        appItemDescriptionLabel.textColor = color
    }
}
