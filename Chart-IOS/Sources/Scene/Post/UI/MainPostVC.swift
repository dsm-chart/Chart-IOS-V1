//
//  MainPostVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit
import MaterialComponents.MaterialButtons
    let dateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY년 MM월 dd일"
    }

class MainPostVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    private let emptyLabel = UILabel().then {
        $0.text = "내용이 없습니다."
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .secondaryLabel
    }

    private let labelBackView = UIView().then {
        $0.backgroundColor = .clear
    }

    private let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(PostCell.self, forCellReuseIdentifier: "PostCell")
    }

    private let dateLabel = UILabel().then {
        $0.textColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .center
    }

    private let postNameLabel = UILabel().then {
        $0.textColor = Asset.labelColor.color
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.textAlignment = .center
    }

    private let createPostFloatingButton = MDCFloatingButton(shape: .default).then {
        $0.setBackgroundColor(Asset.mainColor.color)
        $0.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        $0.setImageTintColor(.white, for: .normal)
    }

    override func setLayout() {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func configureUI() {
        [labelBackView, dateLabel, postNameLabel, tableView, createPostFloatingButton].forEach {
            view.addSubview($0)
        }

        dateLabel.text = "0000-00-00"
        dateLabel.text = dateFormatter.string(from: Date())
        postNameLabel.text = "학교 게시판"
        bind(reactor: reactor)
    }

        createPostFloatingButton.rx.tap.bind {
            self.navigationController?.pushViewController(AddPostVC(), animated: true)
        }.disposed(by: disposeBag)
    }
    
    override func setupConstraints() {
        createPostFloatingButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
        }
        labelBackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(
                    -(self.navigationController?.navigationBar.frame.height ?? 0.0))
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.centerY).offset(-234.5)
        }

        dateLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(postNameLabel.snp.top)
        }

        postNameLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(labelBackView).offset(20)
        }

        tableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(labelBackView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
