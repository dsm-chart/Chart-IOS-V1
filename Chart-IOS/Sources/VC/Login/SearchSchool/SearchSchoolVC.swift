//
//  SearchSchoolVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/19.
//

import UIKit

class SearchSchoolVC: BaseViewController {
    
    private let textFieldBackView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderColor = Asset.mainColor.color.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 10
    }
    
    
    private let schoolSearchTextField = UITextField().then {
        $0.borderStyle = .none
        $0.font = .roundedFont(ofSize: 18, weight: .medium)
        $0.tintColor = Asset.mainColor.color
        $0.attributedPlaceholder = NSAttributedString(string: "학교를 검색하세요", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
            NSAttributedString.Key.font : UIFont.roundedFont(ofSize: 18, weight: .medium)
        ])
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func configureUI() {
        
        [textFieldBackView, tableView].forEach {
            view.addSubview($0)
        }
        
        textFieldBackView.addSubview(schoolSearchTextField)
        
    }
    
    override func setupConstraints() {
        textFieldBackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(view).inset(25)
        }

        schoolSearchTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(textFieldBackView).inset(10)
            $0.top.bottom.equalTo(textFieldBackView).inset(15)
        }
        
    }

}
