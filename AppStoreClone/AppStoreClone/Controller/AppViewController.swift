//
//  AppViewController.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import UIKit
import SnapKit

final class AppViewController: UIViewController {
    
    // MARK: - View
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AppSingleListCollectionViewCell.self, forCellWithReuseIdentifier: AppSingleListCollectionViewCell.identifier)
        collectionView.register(AppListCollectionViewCell.self, forCellWithReuseIdentifier: AppListCollectionViewCell.identifier)
        collectionView.register(AppCollectionViewHeaderCell.self, forCellWithReuseIdentifier: AppCollectionViewHeaderCell.identifier)
        
        return collectionView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Method
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout()
        self.view.addSubview(collectionView)
    }
    
    // MARK: - CompositionalLayout
    private func singleListLayout() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        // let section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    private func listLayout() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 0, bottom: 0, trailing: 0)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(240))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] (section, _) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch section {
            case 0:
                return self.singleListLayout()
            case 1:
                return self.listLayout()
            default:
                return nil
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension AppViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 20
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let singleListCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppSingleListCollectionViewCell.identifier, for: indexPath) as? AppSingleListCollectionViewCell else { return UICollectionViewCell() }
        
        guard let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppListCollectionViewCell.identifier, for: indexPath) as? AppListCollectionViewCell else { return UICollectionViewCell() }
        
        guard let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCollectionViewHeaderCell.identifier, for: indexPath) as? AppCollectionViewHeaderCell else { return UICollectionViewCell() }
        
        switch indexPath.section {
        case 0: return headerCell
        case 1: return listCell
        default: return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension AppViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

