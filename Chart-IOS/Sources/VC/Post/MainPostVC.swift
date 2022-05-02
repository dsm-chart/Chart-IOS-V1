//
//  MainPostVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit
import MaterialComponents.MaterialButtons


class MainPostVC: BaseViewController {
    
    private let labelBackView = UIView().then {
        $0.backgroundColor = .clear
    }
        
    private let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
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
        [createPostFloatingButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        createPostFloatingButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
        }
    }
    
}
