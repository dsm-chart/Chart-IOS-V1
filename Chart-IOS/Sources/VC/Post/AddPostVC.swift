//
//  AddPostVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/16.
//

import UIKit

class AddPostVC: BaseViewController {
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = Asset.mainColor.color
        $0.text = "제목 :"
    }

    fileprivate let titleTextField = UITextField().then {
        $0.borderStyle = .none
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.tintColor = Asset.mainColor.color
        $0.attributedPlaceholder = NSAttributedString(string: "제목을 입력하세요", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.separator,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .semibold)
        ])
    }
    
    let textViewPlaceHolder = "여기에 본문을 입력해 주세요"
    
    fileprivate lazy var contentTextView = UITextView().then {
        $0.tintColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 18, weight: .regular)
        $0.text = textViewPlaceHolder
        $0.textColor = .separator
    }
    
    override func configureUI() {
        contentTextView.delegate = self
    }
    
}
