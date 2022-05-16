//
//  MainPostVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit
import MaterialComponents.MaterialButtons

class MainPostVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let labelBackView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(MainPostCell.self, forCellReuseIdentifier: "mainPostCell")
    }
    
    private let dateLabel = UILabel().then {
        $0.textColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let postNameLabel = UILabel().then {
        $0.textColor = Asset.labelColor.color
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let createPostFloatingButton = MDCFloatingButton(shape: .default).then {
        $0.setBackgroundColor(Asset.mainColor.color)
        $0.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        $0.setImageTintColor(.white, for: .normal)
    }
    
    override func configureUI() {
        [labelBackView, dateLabel, postNameLabel, tableView, createPostFloatingButton].forEach {
            view.addSubview($0)
        }
        
        dateLabel.text = "0000-00-00"
        postNameLabel.text = "학교 게시판"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setupConstraints() {
        createPostFloatingButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
        }
        labelBackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-(self.navigationController?.navigationBar.frame.height ?? 0.0))
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.centerY).offset(-234.5)
        }
        
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(postNameLabel.snp.top)
        }
        
        postNameLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(labelBackView).offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(labelBackView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return MainPostCell()
    }
    
}
