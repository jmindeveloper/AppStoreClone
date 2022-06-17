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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.collectionViewLayout = layout()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        configureCostraints()
    }
    
    // MARK: - Method
    private func configureCostraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        print("Asdf")
    }
}
