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
        
        let tabOne = UINavigationController(rootViewController: SchoolMealVC())
        let tabOneBarItem = UITabBarItem(title: "급식", image: UIImage(systemName: "fork.knife"), tag: 1)
        
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UINavigationController(rootViewController: TimeTableVC())
        let tabTwoBarItem2 = UITabBarItem(title: "시간표", image: UIImage(systemName: "timer"), tag: 2)
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        let tabThr = UINavigationController(rootViewController: MainPostVC())
        let tabThrBarItem3 = UITabBarItem(title: "게시판", image: UIImage(systemName: "list.bullet"), tag: 3)
        
        tabThr.tabBarItem = tabThrBarItem3
        
        let tabFou = UINavigationController(rootViewController: SettingVC())
        let tabFouBarItem4 = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape.fill"), tag: 4)
        
        tabFou.tabBarItem = tabFouBarItem4
        
        self.tabBar.tintColor = Asset.mainColor.color
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Asset.mainColor.color], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Asset.mainColor.color], for:.selected)
        
        self.viewControllers = [tabOne, tabTwo, tabThr, tabFou]
    }
}
