//
//  SceneDelegate.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/07.
//

import UIKit
import RxSwift
import SPAlert

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let disposeBag = DisposeBag()
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if KeyChain.read(key: Token.refreshToken) != nil {
            LoginManager.shared.postReissue().bind { bool in
                if bool == true { self.goMainHome() }
            }.disposed(by: disposeBag)
        } else { goLogin() }
        
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
    
    func presentAlert(_ title: String, _ preset: SPAlertIconPreset) {
        let alertView = SPAlertView(title: title, preset: preset)
        alertView.duration = 1
        alertView.present()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        if let url = URLContexts.first?.url {
            print("URLContexts: \(url)")
            if url.absoluteString.starts(with: "githubprviewer://") {
                if let code = url.absoluteString.split(separator: "=").last.map({ String($0) }) {
                    print("Code: \(code)")
                    KeyChain.create(key: Token.gituhbCode, token: code)
                    LoginManager.shared.requestAccessToken(code: code).bind { bool in
                        if bool == true {
                            LoginManager.shared.checkGithubUser().bind { string in
                                if string == "true" {
                                    print(string)
                                    LoginManager.shared.login().bind { bool in
                                        print(bool)
                                        if bool == true { self.presentAlert("로그인 성공!", .done) }
                                        if bool == false { self.presentAlert("로그인 실패!", .error) }
                                    }.disposed(by: self.disposeBag)
                                } else if string == "false" {
                                    let mainViewController = BaseNavigationController(rootViewController: LoginVC())
                                    mainViewController.pushViewController(SignInVC(), animated: true)
                                    self.window?.rootViewController = mainViewController
                                } else { self.presentAlert("알 수 없는 오류 발생!", .error) }
                            }.disposed(by: self.disposeBag)
                        }
                    }.disposed(by: disposeBag)
                }
            }
        }
    }
}
