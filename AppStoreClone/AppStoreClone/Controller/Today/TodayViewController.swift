//
//  TodayViewController.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import UIKit
import Combine

final class TodayViewController: UIViewController {
    
    // MARK: - View
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TodayCareViewCell.self, forCellWithReuseIdentifier: TodayCareViewCell.identifier)
        
        return collectionView
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        
        return blurView
    }()
    
    private let customTransition = TodayViewControllerTransitionAnimator()
    
    // MARK: - Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout()
        view.addSubview(collectionView)
        view.addSubview(blurEffectView)
        blurEffectView.isHidden = true
        
        configureStatusBar()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - CompositionalLayout
    private func createCardCellLayout() -> NSCollectionLayoutSection {
        let screenWidth = UIScreen.main.bounds.width
        let margine = screenWidth * 0.1 / 2
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 0, bottom: 30, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: margine, bottom: 0, trailing: margine)
        
        return section
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.createCardCellLayout()
        }
    }
    
    // MARK: - Method
    private func getSelectedCellFrame() -> CGRect {
        guard let selectedIndex = collectionView.indexPathsForSelectedItems?.first,
              let selectedCell = collectionView.cellForItem(at: selectedIndex) else {
            return .zero
        }
        let selectedCellFrame = selectedCell.convert(selectedCell.bounds, to: nil)
        return selectedCellFrame
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
        
        let statusBarHeight = statusBarManager?.statusBarFrame.height
        
        let statusBarView = UIView(frame: statusBarManager?.statusBarFrame ?? CGRect.zero)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.view.addSubview(statusBarView)
        statusBarView.addSubview(blurEffectView)
        
        statusBarView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(statusBarHeight ?? 47)
        }
        
        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCareViewCell.identifier, for: indexPath) as? TodayCareViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TodayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = TodayCardDetailViewController()
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.transitioningDelegate = self
        self.present(detailVC, animated: true)
        
    }
}

extension TodayViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        customTransition.originFrame = getSelectedCellFrame()
        customTransition.presenting = .present
        
        return customTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        customTransition.presenting = .dismiss
        return customTransition
    }
}
