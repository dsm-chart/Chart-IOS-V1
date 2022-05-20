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
        $0.text = "제목 : "
    }

    private let titleTextField = UITextField().then {
        $0.borderStyle = .none
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.tintColor = Asset.mainColor.color
    }

    fileprivate let textViewPlaceHolder = "여기에 본문을 입력해 주세요"

    private lazy var contentTextView = UITextView().then {
        $0.tintColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 18, weight: .regular)
        $0.text = textViewPlaceHolder
        $0.textColor = .separator
        $0.backgroundColor = .clear
    }

    override func setLayout() {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true // <- 이코드가 꼭 있어야함
    }

    override func configureUI() {
        contentTextView.delegate = self
        navigationItem.title = "새 글 작성하기"
        [titleLabel, titleTextField, contentTextView].forEach {
            view.addSubview($0)
        }
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.height.equalTo(35)
            $0.width.equalTo(45)
        }
        titleTextField.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(15)
            $0.height.equalTo(35)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.trailing.equalTo(-15)
        }
        contentTextView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(15)
            $0.top.equalTo(titleTextField.snp.bottom).offset(15)
            $0.bottom.equalToSuperview()
        }
    }
}

extension AddPostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = Asset.labelColor.color
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .separator
        }
    }
}
