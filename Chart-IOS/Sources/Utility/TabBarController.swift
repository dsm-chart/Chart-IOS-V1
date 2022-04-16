//
//  TabBarController.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/16.
//

import UIKit


class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.tintColor = Asset.mainColor.color
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Asset.mainColor.color], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Asset.mainColor.color], for:.selected)
    }
}
