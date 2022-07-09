//
//  MyPostVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/07/07.
//

import Foundation
    
    override func setLayout() {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true // <- 이코드가 꼭 있어야함
    }
    
