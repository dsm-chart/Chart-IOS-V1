//
// ReadCommentVC.swift
// Created by 김대희 on 2022/05/23.
//

import UIKit
import ReactorKit

class ReadCommentVC: BaseViewController, View {

    var postId = ""
    let reactor = ReadCommentReactor()

    private let tableView = UITableView().then {
        $0.backgroundColor = Asset.backgroundColor.color
        $0.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        $0.separatorStyle = .none
    }

    private let writeCommentButton = UIButton()

    override func configureUI() {
        navigationItem.title = "Comment"
        writeCommentButton.makeMyDesign(
                color: Asset.mainColor.color,
                title: "Comment 작성하기",
                titleColor: .white)

        [tableView, writeCommentButton].forEach {
            view.addSubview($0)
        }
        bind(reactor: reactor)
    }

    func bind(reactor: ReadCommentReactor) {
        rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidLoad(self.postId) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        writeCommentButton.rx.tap
            .bind { _ in
                let addCommentVC = AddCommentVC()
                print(self.postId)
                addCommentVC.postId = self.postId
                self.navigationController?.pushViewController(addCommentVC, animated: true)
            }.disposed(by: disposeBag)

        reactor.state
                .map { $0.list }
                .bind(to: tableView.rx.items(
                        cellIdentifier: "PostCell",
                        cellType: PostCell.self)) {(row, element: Comment, cell) in
                            cell.firstLabel.text = element.writer.githubId
                            cell.contentLabel.text = element.content
                }.disposed(by: disposeBag)

    }

    override func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
        writeCommentButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(15)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
        }
    }

}
