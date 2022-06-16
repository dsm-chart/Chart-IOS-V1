//
//  MainPostVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit
import MaterialComponents.MaterialButtons
import ReactorKit

class MainPostVC: BaseViewController, View {
    
    let reactor = MainPostReactor()
    
    let dateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY년 MM월 dd일"
    }

    let refreshControl = UIRefreshControl()
    
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

    let dateLabel = UILabel().then {
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
        
        refreshControl.tintColor = Asset.labelColor.color
        refreshControl.endRefreshing() // 초기화 - refresh 종료
        tableView.refreshControl = refreshControl

        dateLabel.text = dateFormatter.string(from: Date())
        postNameLabel.text = "학교 게시판"
        bind(reactor: reactor)
    }
    
    func bind(reactor: MainPostReactor) {
        createPostFloatingButton.rx.tap.bind {
            self.navigationController?.pushViewController(AddPostVC(), animated: true)
        }.disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .map { Reactor.Action.refreshList }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(QuestionData.self)
            .bind { [weak self] in
                let nextVC = ReadPostVC()
                self?.navigationController?.pushViewController(nextVC, animated: true)
                nextVC.navigationItem.title = "\($0.writer.githubId)님의 개시물"
                nextVC.dateLabel.text = "\($0.writer.githubId)님이 작성했어요"
                nextVC.titleTextLabel.text = $0.title
                nextVC.contentTextView.text = $0.content
                nextVC.postId = $0.id
            }.disposed(by: disposeBag)
        
        reactor.state
                .map { $0.list }
                .bind(to: tableView.rx.items(
                        cellIdentifier: "PostCell",
                        cellType: PostCell.self)) {(row, element: QuestionData, cell) in
                            cell.firstLabel.text = element.title
                            cell.secondLabel.text = element.writer.name
                            cell.contentLabel.text = element.content

                }.disposed(by: disposeBag)
                
        reactor.state
            .map { $0.isLoading }
            .delay(DispatchTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
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
