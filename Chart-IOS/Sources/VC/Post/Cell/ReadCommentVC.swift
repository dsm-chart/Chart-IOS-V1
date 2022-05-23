//
// ReadCommentVC.swift
// Created by 김대희 on 2022/05/23.
//

import UIKit

class ReadCommentVC: BaseViewController {

    private let tableView = UITableView().then {
        $0.backgroundColor = Asset.viewColor.color
        $0.layer.cornerRadius = 20
    }

    private let writeCommentButton = UIButton()

    override func configureUI() {
        navigationItem.title = "Comment"
        writeCommentButton.makeMyDesign(color: Asset.mainColor.color, title: "Comment 작성하기", titleColor: .white)
        [tableView, writeCommentButton].forEach {
            view.addSubview($0)
        }
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        writeCommentButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(15)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
        }
    }
}
