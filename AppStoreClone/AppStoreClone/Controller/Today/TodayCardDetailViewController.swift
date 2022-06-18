//
//  TodayCardDetailViewController.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/17.
//

import UIKit

class TodayCardDetailViewController: UIViewController {
    
    // MARK: - View
    private var todayCardView: TodayCardView?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    private let scrollContentView = UIView()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
                let label = UILabel()
                
                return label
            }()
            
            // MARK: - LifeCycle
            override func viewDidLoad() {
                super.viewDidLoad()
                view.backgroundColor = .systemBackground
                
                view.addSubview(scrollView)
                scrollView.addSubview(scrollContentView)
                scrollContentView.addSubview(descriptionLabel)
                configureConstraints()
            }
            
            func configure(with cardView: TodayCardView) {
                todayCardView = cardView
                guard let todayCardView = todayCardView,
                      let type = cardView.cardViewType
                else { return }
                todayCardView.cardViewMode = .full
                todayCardView.configureLayout(with: type)
                scrollContentView.addSubview(todayCardView)
            }
            
            private func configureConstraints() {
                guard let todayCardView = todayCardView else { return }

                
                scrollView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
                
                scrollContentView.snp.makeConstraints {
                    $0.width.equalToSuperview()
                    $0.centerX.top.bottom.equalToSuperview()
                }
                
                todayCardView.snp.makeConstraints {
                    $0.top.leading.trailing.equalToSuperview()
                    $0.height.equalTo(todayCardView.snp.width).multipliedBy(1.1)
                }
                
                descriptionLabel.snp.makeConstraints {
                    $0.width.equalToSuperview().multipliedBy(0.9)
                    $0.centerX.equalToSuperview()
                    $0.bottom.top.equalTo(t
        """
        
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        button.tintColor = .label
        button.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .regular, scale: .default), forImageIn: .normal)
        
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        view.addSubview(dismissButton)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(descriptionLabel)
        
        scrollView.delegate = self
        dismissButton.addTarget(self, action: #selector(dismissAction(_:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraints()
    }
    
    // MARK: - Method
    func configure(with cardView: TodayCardView) {
        todayCardView = cardView
        guard let todayCardView = todayCardView,
              let type = cardView.cardViewType
        else { return }
        todayCardView.cardViewMode = .full
        todayCardView.configureLayout(with: type, mode: .full)
        scrollContentView.addSubview(todayCardView)
    }
    
    private func configureConstraints() {
        guard let todayCardView = todayCardView else { return }
        
        dismissButton.snp.makeConstraints {
            $0.size.equalTo(25)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(safeAreaInsets.top + 15)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollContentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        todayCardView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(todayCardView.snp.width).multipliedBy(1.1)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(todayCardView.snp.bottom).offset(15)
            $0.bottom.equalToSuperview().offset(-50)
        }
        
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: todayCardView.frame.height - safeAreaInsets.top, left: 0, bottom: 0, right: 0)
        
    }
        
    @objc private func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension TodayCardDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let todayCardView = todayCardView else { return }
        if scrollView.contentOffset.y < 0 && !scrollView.isTracking {
            todayCardView.snp.remakeConstraints {
                $0.top.equalTo(view.snp.top)
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(view.snp.width).multipliedBy(1.1)
            }
        } else if scrollView.contentOffset.y < 0 && scrollView.isTracking {
            scrollView.contentOffset = .zero
            todayCardView.snp.remakeConstraints {
                $0.top.equalTo(view.snp.top)
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(view.snp.width).multipliedBy(1.1)
            }
        } else {
            todayCardView.snp.remakeConstraints {
                $0.top.equalToSuperview()
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(view.snp.width).multipliedBy(1.1)
            }
        }
    }
}
