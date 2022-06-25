//
//  AddCommentVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/23.
//

import UIKit
import ReactorKit

class AddCommentVC: BaseViewController {
    
    private let commentLabel = UILabel().then {
        $0.text = "Comment를 입력해 주세요"
        $0.textColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 18, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let commentDetailLabel = UILabel().then {
        $0.text = "Comment 내용은 100자 이내여야 합니다. "
        $0.textColor = Asset.labelColor.color
        $0.font = .roundedFont(ofSize: 17, weight: .regular)
        $0.textAlignment = .center
    }
    
    let commentTextField = UITextField().then {
        $0.borderStyle = .none
        $0.tintColor = Asset.mainColor.color
        $0.placeholder = "Comment를 입력하세요..."
    }
    
    let doneButton = UIButton()

    let textFieldBottomLine = UIView().then { $0.backgroundColor = .separator }

    override func configureUI() {

        [commentLabel, commentDetailLabel, commentTextField, textFieldBottomLine, doneButton]
                .forEach { view.addSubview($0) }

        doneButton.makeMyDesign(
                color: Asset.mainColor.color,
                title: "작성하기",
                titleColor: .white)

    }

    override func setupConstraints() {

        commentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(40)
        }
        commentDetailLabel.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(10)
            $0.left.right.equalTo(view).inset(20)
            $0.height.equalTo(15)
        }

        textFieldBottomLine.snp.makeConstraints {
            $0.top.equalTo(commentTextField.snp.bottom).offset(5)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(40)
        }

        commentTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(commentLabel.snp.bottom).offset(70)
        }

        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(50)
        }

    }
}
