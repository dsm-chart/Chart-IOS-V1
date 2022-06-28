//
// ReadPostVC.swift
//
// Created by 김대희 on 2022/05/17.
//

import UIKit

class ReadPostVC: BaseViewController {
    
    var postId = ""

    let titleTextLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.tintColor = Asset.mainColor.color
    }

    let dateLabel = UILabel().then {
        $0.textColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 12, weight: .regular)
    }

    lazy var contentTextView = UITextView().then {
        $0.isEditable = false
        $0.tintColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 18, weight: .regular)
        $0.textColor = Asset.labelColor.color
        $0.backgroundColor = .clear
    }

    override func setLayout() {
        tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true // <- 이코드가 꼭 있어야함
    }

    private let goCommentButton = UIButton()

    override func configureUI() {

        [titleTextLabel, dateLabel, contentTextView, goCommentButton].forEach {
            view.addSubview($0)
        }
        goCommentButton.makeMyDesign(
                color: Asset.mainColor.color,
                title: "Comment 보기",
                titleColor: .white)
        
        goCommentButton.rx.tap.bind {
            let readCommentVC = ReadCommentVC()
            readCommentVC.postId = self.postId
            self.navigationController?.pushViewController(readCommentVC, animated: true)
        }.disposed(by: disposeBag)
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
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let bottom = windowScene?.windows.first?.safeAreaInsets.bottom ?? 0.0

        goCommentButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(15)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view).offset(-bottom - 5) // 일단 이거 safe area 바꿔야됨, 안되는 중임
        }
    }

}
