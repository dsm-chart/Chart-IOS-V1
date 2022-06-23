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
        $0.font = .roundedFont(ofSize: 24, weight: .semibold)
    }
    
    private let commentDetailLabel = UILabel().then {
        $0.text = "제목은 100자 이내여야 합니다. "
        $0.textColor = Asset.labelColor.color
        $0.font = .roundedFont(ofSize: 17, weight: .regular)
    }
    
    let commentTextField = UITextField().then {
        $0.borderStyle = .line
        $0.tintColor = Asset.mainColor.color
        $0.placeholder = "Comment를 입렷하세요..."
    }
    
    let doneButton = UIButton()
    
    override func configureUI() {
        [commentLabel, commentDetailLabel, commentTextField, doneButton]
                .forEach { view.addSubview($0) }

        doneButton.makeMyDesign(
                color: Asset.mainColor.color,
                title: "작성하기",
                titleColor: .white)
    }
}