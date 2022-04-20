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
    
    private let textFieldBackShadowView = UIView()
    
    private let gradintLayer = CAGradientLayer().then {
        $0.colors = [Asset.mainColor.color.cgColor, UIColor.clear.cgColor]
    }
    
    private let schoolSearchTextField = UITextField().then {
        $0.borderStyle = .none
        $0.font = .roundedFont(ofSize: 18, weight: .medium)
        $0.tintColor = Asset.mainColor.color
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func configureUI() {
        
        gradintLayer.frame = self.view.bounds
        
        [textFieldBackShadowView, textFieldBackView, tableView].forEach {
            view.addSubview($0)
        }

        textFieldBackShadowView.layer.addSublayer(gradintLayer)
    
    }

}
