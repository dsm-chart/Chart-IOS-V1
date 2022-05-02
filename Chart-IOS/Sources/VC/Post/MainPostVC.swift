//
//  MainPostVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class MainPostVC: BaseViewController {

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
