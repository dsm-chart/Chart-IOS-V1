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
        window = UIWindow(windowScene: windowScene)
        
        if KeyChain.read(key: Token.refreshToken) == nil {
            goLogin()
        } else {
            goMainHome()
        }
        
        window?.makeKeyAndVisible()
        
        #if targetEnvironment(macCatalyst)
        if let titlebar = windowScene.titlebar {
            titlebar.titleVisibility = .hidden
            titlebar.toolbar = nil
        }
        #endif
        
    }
    
    func goMainHome() {
        let mainViewController = TabBarController()
        window?.rootViewController = mainViewController
    }
    
    func goLogin() {
        let mainViewController = BaseNavigationController(rootViewController: LoginVC())
        window?.rootViewController = mainViewController
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            print("URLContexts: \(url)")
            if url.absoluteString.starts(with: "githubprviewer://") {
                if let code = url.absoluteString.split(separator: "=").last.map({ String($0) }) {
                    print("Code: \(code)")
                    LoginManager.shared.requestAccessToken(with: code)
                }
            }
        }
    }
    
}
