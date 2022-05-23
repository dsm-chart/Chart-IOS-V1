//
//  SettingVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit

class SettingVC: BaseViewController {
    
    private let labelBackView = UIView().then {
        $0.backgroundColor = .clear
    }

    private let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(PostCell.self, forCellReuseIdentifier: "PostCell")
    }

    private let subTitleLabel = UILabel().then {
        $0.textColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .center
    }

    private let titleLabel = UILabel().then {
        $0.textColor = Asset.labelColor.color
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.textAlignment = .center
    }
    
    override func configureUI() {
        [labelBackView, tableView].forEach {
            view.addSubview($0)
        }
        [subTitleLabel, titleLabel].forEach {
            labelBackView.addSubview($0)
        }
    }
}
