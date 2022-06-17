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
        print(collectionView.contentOffset)
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
    
    private func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] _, _ -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.creatCardCellLayout()
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
}

extension TodayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension TodayViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y + safeAreaInsets.top)
        statusBarBlurViewHidden(false)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + safeAreaInsets.top == 0 {
            print(scrollView.contentOffset.y + safeAreaInsets.top)
            statusBarBlurViewHidden(true)
        }
    }
}
