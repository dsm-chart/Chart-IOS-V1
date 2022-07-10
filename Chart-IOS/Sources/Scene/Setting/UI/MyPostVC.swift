//
//  MyPostVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/07/07.
//

import UIKit
import RxSwift

class MyPostVC: BaseViewController {

    var myList: [QuestionList] = []

    private let tableView = UITableView().then {
        $0.backgroundColor = Asset.backgroundColor.color
        $0.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        $0.separatorStyle = .none
    }

    override func configureUI() {
        navigationItem.title = "내가 작성한 게시물"

        [tableView].forEach {
            view.addSubview($0)
        }

        let list = Observable.just(myList)

        list.bind(to: tableView.rx.items(
            cellIdentifier: "PostCell",
            cellType: PostCell.self)) {(row, element: QuestionList, cell) in
                cell.firstLabel.text = element.title
                cell.contentLabel.text = element.content
        }.disposed(by: disposeBag)

    }
    
    override func setLayout() {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true // <- 이코드가 꼭 있어야함
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
    }

}
