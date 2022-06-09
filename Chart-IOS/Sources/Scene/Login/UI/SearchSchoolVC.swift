//
//  SearchSchoolVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/19.
//

import UIKit
import RxKeyboard
import PanModal
import ReactorKit

class SearchSchoolVC: BaseViewController, PanModalPresentable, View {
    
    var hasLoaded = true
    var panScrollable: UIScrollView? { return nil }
    let reactor = SearchSchoolReactor()
    
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
        $0.returnKeyType = .search
        $0.font = .roundedFont(ofSize: 18, weight: .medium)
        $0.tintColor = Asset.mainColor.color
        $0.attributedPlaceholder = NSAttributedString(string: "학교를 검색하세요", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
            NSAttributedString.Key.font: UIFont.roundedFont(ofSize: 18, weight: .medium)
        ])
    }
    
    let tableView = UITableView().then {
        $0.register(SearchSchoolTableViewCell.self, forCellReuseIdentifier: "searchSchoolTableViewCell")
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
    }
    
    private let searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = Asset.mainColor.color
    }
    
    override func configureUI() {
        [textFieldBackView, tableView].forEach {
            view.addSubview($0)
        }
        
        [schoolSearchTextField, searchButton].forEach {
            textFieldBackView.addSubview($0)
        }
        bind(reactor: reactor)
    }
    
    func bind(reactor: SearchSchoolReactor) {
        
        schoolSearchTextField.rx.text.bind { text in
            if text!.isEmpty {
                UIView.animate(withDuration: 0.2) { self.searchButton.tintColor = .clear }
            } else {
                UIView.animate(withDuration: 0.2) { self.searchButton.tintColor = Asset.mainColor.color }
            }
        }.disposed(by: disposeBag)

        searchButton.rx.tap
            .map { Reactor.Action.searchSchool(self.schoolSearchTextField.text ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.schoolList }
            .bind(to: tableView.rx.items(
                cellIdentifier: "searchSchoolTableViewCell",
                cellType: SearchSchoolTableViewCell.self)) {(row, element: SearchSchoolResponse, cell) in
                    cell.schoolLabel.text = element.name
                    cell.areaLabel.text = element.addressCode
                }.disposed(by: disposeBag)
    }
    
    override func setupConstraints() {
        textFieldBackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(view).inset(25)
        }
        
        schoolSearchTextField.snp.makeConstraints {
            $0.trailing.equalTo(-45)
            $0.leading.equalTo(textFieldBackView).inset(10)
            $0.top.bottom.equalTo(textFieldBackView).inset(15)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(textFieldBackView.snp.bottom).offset(10)
            $0.bottom.equalTo(0)
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalTo(textFieldBackView).offset(-10)
            $0.width.equalTo(30)
            $0.top.bottom.equalTo(textFieldBackView).inset(10)
        }
    }
    
    // dunny & Test Code
}
