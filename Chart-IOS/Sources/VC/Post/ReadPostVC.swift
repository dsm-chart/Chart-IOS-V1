//
// ReadPostVC.swift
//
// Created by 김대희 on 2022/05/17.
//

import UIKit

class ReadPostVC: BaseViewController {

    private let titleTextLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.tintColor = Asset.mainColor.color
    }

    private let dateLabel = UILabel().then {
        $0.textColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 12, weight: .regular)
    }

    private lazy var contentTextView = UITextView().then {
        $0.isEditable = false
        $0.tintColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 18, weight: .regular)
        $0.textColor = Asset.labelColor.color
        $0.backgroundColor = .clear
    }

    override func setLayout() {
        tabBarController?.tabBar.isHidden = true
    }

    override func configureUI() {
        navigationItem.title = "OOO님의 개시물"
        titleTextLabel.text = "제목이 들어가요."
        dateLabel.text = "0000-00-00 시간에 OOO님이 작성했어요."
        contentTextView.text = "여기에는 본문이 들어가고 곧 삭제될 더미데이터 에여 ㅎㅎ"
        [titleTextLabel, dateLabel, contentTextView].forEach {
            view.addSubview($0)
        }
    }

    override func setupConstraints() {
        titleTextLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(15)
            $0.height.equalTo(35)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(view).inset(15)
            $0.height.equalTo(20)
        }
        contentTextView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(15)
            $0.top.equalTo(dateLabel.snp.bottom).offset(15)
            $0.bottom.equalToSuperview()
        }
    }

}
