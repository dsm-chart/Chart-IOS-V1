//
//  BaseNavigationController.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/03.
//

import UIKit

class BaseNavigationController: UINavigationController {

    private var backButtonImage: UIImage? {
        return UIImage(
            systemName: "chevron.backward")?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -12.0, bottom: 0.0, right: 0.0))
    }
    
    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        return backButtonAppearance
    }
    
    static func makeNavigationController(rootViewController: UIViewController) -> BaseNavigationController {
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearance()
    }
    
    func setNavigationBarAppearance() {
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        self.navigationController?.navigationBar.standardAppearance = appearance
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.configureWithTransparentBackground()
        appearance.backButtonAppearance = backButtonAppearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = Asset.mainColor.color
        
    }

}
