//
//  SearchSchoolVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/19.
//

import UIKit

class SearchSchoolVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let headFooterView = UIView().then {
        $0.backgroundColor = .clear
    }
    
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
        $0.register(SearchSchoolTableViewCell.self, forCellReuseIdentifier: "searchSchoolTableViewCell")
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    private let searchButton = UIButton()
    
    override func configureUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchButton.makeMyDesign(color: Asset.mainColor.color, title: " 검색", titleColor: .white, image: Asset.github.image)
        
        [textFieldBackView, tableView, searchButton].forEach {
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
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(textFieldBackView.snp.bottom).offset(10)
            $0.bottom.equalTo(searchButton.snp.top).offset(25)
        }
        
        searchButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(25)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
        }
        
    }
    
    // dunny & Test Code
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SearchSchoolTableViewCell()
    }
    
    /// Header & Footer View
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return headFooterView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
}
