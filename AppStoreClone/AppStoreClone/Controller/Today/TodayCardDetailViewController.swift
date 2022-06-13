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
    
    // MARK: - Properties
    let cancelBlur = PassthroughSubject<Void, Never>()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        view.addSubview(dismissButton)
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
    }
    
    @objc private func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
        cancelBlur.send()
    }
}
