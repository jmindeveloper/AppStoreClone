//
//  TodayCardCell.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/16.
//

import UIKit
import SnapKit

final class TodayCardCell: UICollectionViewCell {
    static let identifier = "TodayCardCell"
    
    var cellView: TodayCardView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellView?.layer.cornerRadius = 20
        cellView?.layer.masksToBounds = true
    }
    
    private func configureView() {
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func configure(with cellview: TodayCardView) {
        cellView = cellview
        guard let cellView = cellView else { return }
        
        cellView.configureLayout(with: cellView)
        
        self.contentView.addSubview(cellView)
        cellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
