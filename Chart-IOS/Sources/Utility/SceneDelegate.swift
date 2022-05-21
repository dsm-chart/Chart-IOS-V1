//
//  SceneDelegate.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene) // SceneDelegate의 프로퍼티에 설정해줌
//        let mainViewController = BaseNavigationController(rootViewController: LoginVC())
        let mainViewController = TabBarController() // First ViewController

        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        
        #if targetEnvironment(macCatalyst)
        
        if let titlebar = windowScene.titlebar {
            titlebar.titleVisibility = .hidden
            titlebar.toolbar = nil
        }
        #endif
        
    }
}

