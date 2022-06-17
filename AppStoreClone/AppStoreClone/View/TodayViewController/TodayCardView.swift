//
//  TodayCardView.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/16.
//

import UIKit

final class TodayCardView: UIView {
    
    var cardViewType: CardViewType?
    private var appCollection: [AppModel]?
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let appIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let appCollectionTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodayCardAppCollectionTableViewCell.self, forCellReuseIdentifier: TodayCardAppCollectionTableViewCell.identifier)
        
        return tableView
    }()
    
    private let appTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    init(type: CardViewType) {
        self.cardViewType = type
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        appCollectionTableView.rowHeight = (appCollectionTableView.frame.height - 15) / 4
    }
    
    // MARK: - Method
    private func configureTextColor() {
        backgroundImageView.image?.getAverageColor(completion: { [weak self] color in
            [self?.titleLabel, self?.subtitleLabel, self?.appTitleLabel, self?.categoryLabel].forEach {
                $0?.textColor = color
            }
        })
    }
    
//    func configureLayout(with cardModel: TodayCardView) {
    func configureLayout(with cardViewType: CardViewType) {
//        let cardViewType = cardModel.cardViewType
        switch cardViewType {
        case .appOfTheDay(let backgroundImage, let app):
            configureAppOfTheDayLayout(image: backgroundImage, app: app)
            configureTextColor()
        case .appCollection(let apps, let title, let subtitle):
            configureAppCollectionLayout(apps: apps, title: title, subtitle: subtitle)
            appCollection = apps
        case .appArticle(let backgroundImage, let title, let subtitle, let app):
            configureAppArticleLayout(image: backgroundImage, title: title, subtitle: subtitle, app: app)
            configureTextColor()
        }
    }
    
    private func configureAppOfTheDayLayout(image backgroundImage: UIImage, app: AppModel) {
        addSubview(backgroundImageView)
        [appIconView, titleLabel, appTitleLabel, categoryLabel].forEach {
            backgroundImageView.addSubview($0)
        }
        backgroundImageView.image = backgroundImage
        appIconView.image = app.iconImage
        appTitleLabel.text = app.appName
        titleLabel.text = "APP\nOFF THE\nDAY"
        categoryLabel.text = app.category
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        
        backgroundImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalToSuperview()
        }
        
        appIconView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.top.equalTo(appIconView.snp.bottom).offset(20)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        appTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(categoryLabel)
            $0.bottom.equalTo(categoryLabel.snp.top).offset(-1)
        }
    }
    
    private func configureAppCollectionLayout(apps : [AppModel], title: String, subtitle: String) {
        appCollectionTableView.dataSource = self
        appCollectionTableView.separatorStyle = .none
        subtitleLabel.text = subtitle
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.backgroundColor = UIColor(named: "SingleListCellColor")
        appCollectionTableView.backgroundColor = UIColor(named: "SingleListCellColor")
        
        [subtitleLabel, titleLabel, appCollectionTableView].forEach {
            addSubview($0)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(subtitleLabel.snp.leading)
        }
        
        appCollectionTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func configureAppArticleLayout(image backgroundImage: UIImage, title: String , subtitle: String, app: AppModel) {
        addSubview(backgroundImageView)
        backgroundImageView.image = backgroundImage
        subtitleLabel.text = subtitle
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        appTitleLabel.text = app.appName
        categoryLabel.text = app.category
        
        
        [subtitleLabel, titleLabel, appTitleLabel, categoryLabel].forEach {
            backgroundImageView.addSubview($0)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(subtitleLabel.snp.leading)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        appTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(categoryLabel)
            $0.bottom.equalTo(categoryLabel.snp.top).offset(-1)
        }
    }
    
}

extension TodayCardView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayCardAppCollectionTableViewCell.identifier, for: indexPath) as? TodayCardAppCollectionTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = UIColor(named: "SingleListCellColor")
        cell.selectionStyle = .none
        
        guard let appModel = appCollection?[indexPath.item] else { return UITableViewCell() }

        cell.configure(with: appModel, index: indexPath.item)
        
        return cell
    }
}
