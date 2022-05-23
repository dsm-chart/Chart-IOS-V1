//
// ReadCommentVC.swift
// Created by 김대희 on 2022/05/23.
//

import UIKit

class ReadCommentVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView().then {
        $0.backgroundColor = Asset.backgroundColor.color
        $0.separatorStyle = .none
    }

    private let writeCommentButton = UIButton()

    override func configureUI() {
        navigationItem.title = "Comment"
        writeCommentButton.makeMyDesign(color: Asset.mainColor.color, title: "Comment 작성하기", titleColor: .white)
        [tableView, writeCommentButton].forEach {
            view.addSubview($0)
        }
        tableView.delegate = self
        tableView.dataSource = self
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return PostCell()
    }

}
