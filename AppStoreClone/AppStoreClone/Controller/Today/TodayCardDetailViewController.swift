//
//  TodayCardDetailViewController.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/12.
//

import UIKit
import Combine

final class TodayCardDetailViewController: UIViewController {
    
    // MARK: - View
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        let xmark = UIImage(systemName: "xmark")
        xmark?.withRenderingMode(.alwaysTemplate)
        button.setImage(xmark, for: .normal)
        button.imageView?.tintColor = .white
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemGray4
        
        return button
    }()
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1.jpg")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let appItemBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = """
            private func configureConstraints() {
                dismissButton.snp.makeConstraints {
                    $0.width.height.equalTo(40)
                    $0.top.equalToSuperview().offset(60)
                    $0.trailing.equalToSuperview().offset(-30)
                }
                
                scrollView.snp.makeConstraints {
                    $0.leading.trailing.bottom.equalToSuperview()
                    $0.top.equalToSuperview().offset(-safeAreaInsets.top)
                }
                
                contentView.snp.makeConstraints {
                    $0.width.equalToSuperview()
                    $0.top.bottom.equalToSuperview()
                }
                
                cardImageView.snp.makeConstraints {
                    $0.leading.trailing.top.equalToSuperview()
                    $0.height.equalTo(cardImageView.snp.width).multipliedBy(1.2)
                    
                }
                
                appItemBaseView.snp.makeConstraints {
                    $0.leading.trailing.equalToSuperview()
                    $0.bottom.equalTo(cardImageView.snp.bottom)

                    $0.height.equalTo(70)
                }
                
                itemDescriptionLabel.snp.makeConstraints {
                    $0.leading.trailing.equalToSuperview()
                    $0.top.equalTo(cardImageView.snp.bottom)
                    $0.height.equalTo(1000)
                    $0.bottom.equalToSuperview()
                }
            }
            
            @objc private func dismiss(_ sender: UIButton) {
                self.dismiss(animated: true)
                cancelBlur.send()
            }
        }
        """
        
        return label
    }()
    
    private let cardItemStackView = AppItemStackView()
    
    // MARK: - Properties
    let cancelBlur = PassthroughSubject<Void, Never>()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        [scrollView, dismissButton].forEach {
            view.addSubview($0)
        }
        scrollView.addSubview(contentView)
        [cardImageView, itemDescriptionLabel].forEach {
            contentView.addSubview($0)
        }
        cardImageView.addSubview(appItemBaseView)
        appItemBaseView.addSubview(cardItemStackView)
        
        view.layer.masksToBounds = true
        scrollView.backgroundColor = .systemBackground
        dismissButton.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
        
        configureConstraints()
    }
    
    // MARK: - Method
    private func configureConstraints() {
        dismissButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview().offset(60)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(-safeAreaInsets.top)
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        cardImageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(cardImageView.snp.width).multipliedBy(1.2)
            
        }
        
        appItemBaseView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(cardImageView.snp.bottom)

            $0.height.equalTo(70)
        }
        
        itemDescriptionLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cardImageView.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
        
        cardItemStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(-15)
            $0.top.bottom.equalToSuperview()
        }
        
        print(appItemBaseView.frame)
        
    }
    
    @objc private func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
        cancelBlur.send()
    }
}
