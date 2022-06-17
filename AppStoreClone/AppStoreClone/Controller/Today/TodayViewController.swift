//
//  TodayViewController.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import UIKit
import Combine

final class TodayViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TodayCardCell.self, forCellWithReuseIdentifier: TodayCardCell.identifier)
        collectionView.register(TodayHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TodayHeaderView.identifier)
        
        return collectionView
    }()
    
    // MARK: - Properties
    let viewModel = TodayViewModel()
    
    let statusBarBlurView: UIVisualEffectView = {
        let blurView = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurView)
        
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.collectionViewLayout = layout()
        collectionView.dataSource = self
        collectionView.delegate = self
        configureCostraints()
        configureStatusBar()
        statusBarBlurView.alpha = 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: - Method
    private func configureCostraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureStatusBar() {
        var statusBarManager: UIStatusBarManager?
        
        if #available(iOS 15.0, *) {
            let window = UIApplication.shared.connectedScenes
                .map { $0 as? UIWindowScene }
                .compactMap { $0 }
                .first?.windows.first
            statusBarManager = window?.windowScene?.statusBarManager
        } else {
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            statusBarManager = window?.windowScene?.statusBarManager
        }
        
        statusBarBlurView.frame = statusBarManager?.statusBarFrame ?? CGRect.zero
        
        self.view.addSubview(statusBarBlurView)
    }
    
    private func statusBarBlurViewHidden(_ isHidden: Bool) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) { [weak self] in
            if isHidden {
                self?.statusBarBlurView.alpha = 0
            } else {
                self?.statusBarBlurView.alpha = 1
            }
        }
    }
    
    // MARK: - CompositionalLayout
    private func creatCardCellLayout() -> NSCollectionLayoutSection {
        let margine = (screenFrame.width -  screenFrame.width * 0.9) / 2
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1.1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: margine, bottom: 30, trailing: margine)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func creatHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(80))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        return sectionHeader
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] _, _ -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let section = self.creatCardCellLayout()
            section.boundarySupplementaryItems = [self.creatHeader()]
            return section
        }
    }
}

extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCardCell.identifier, for: indexPath) as? TodayCardCell else { return UICollectionViewCell() }
        
        let cardModel = viewModel.cards[indexPath.item]
        guard let cardType = cardModel.viewType else { return UICollectionViewCell() }
        let cellView = TodayCardView(type: cardType)
        
        cell.configure(with: cellView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TodayHeaderView.identifier, for: indexPath) as? TodayHeaderView else { return UICollectionReusableView() }
            
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
}

extension TodayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = TodayCardDetailViewController()
        
        let cardModel = viewModel.cards[indexPath.item]
        guard let cardType = cardModel.viewType else { return }
        let cardView = TodayCardView(type: cardType)
        
        detailVC.configure(with: cardView)
        detailVC.modalPresentationStyle = .custom
        
        self.present(detailVC, animated: true)
    }
}

extension TodayViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        statusBarBlurViewHidden(false)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + safeAreaInsets.top == 0 {
            statusBarBlurViewHidden(true)
        }
    }
}
