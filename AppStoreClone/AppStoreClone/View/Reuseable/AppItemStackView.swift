//
//  AppItemStackView.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/08.
//

import UIKit
import SnapKit

final class AppItemStackView: UIView {
    
    var isTextAverageColor = false {
        willSet {
            appItemTitleLabel.textColor = newValue ? averageColor : .label
            appItemDescriptionLabel.textColor = newValue ? averageColor : .label
        }
    }
    
    // MARK: - View
    let appItemStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 7
        
        return stack
    }()
    
    let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1.jpg")
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    let appItemTitleAndDescriptionStaciView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        
        return stack
    }()
    
    lazy var appItemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "배타러갈래?"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        return label
    }()
    
    lazy var appItemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "돈 많이 벌게 해줄게~~"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        return label
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setDownloadButton()
        button.setTitle("받기", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStack()
        configureCostraints()
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
    
    private func configureCostraints() {
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
}
