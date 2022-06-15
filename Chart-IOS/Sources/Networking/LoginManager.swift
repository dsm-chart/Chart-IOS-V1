//
//  LoginManager.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/30.
//

import Foundation
import Alamofire
import UIKit
import RxSwift
import RxRelay
import SPAlert

class LoginManager {
    
    static let shared = LoginManager()
    private let disposeBag = DisposeBag()
    
    private init() {}
    
    //  어떤 친구가 코드를 잘못 짜서 이거 안써도 됨
    func requestAccessToken(code: String) -> PublishRelay<Bool> {
        let requestToken = PublishRelay<Bool>()
        let parm = GithubCodeRequst.init(code)
        API.postGithubCode(parm).request().subscribe { event in
            switch event {
            case .success(let response):
                if let json = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any] {
                    if let dic = json as? [String: String] {
                        let githubAccessToken = dic["access_token"]
                        print(githubAccessToken ?? "")
                        KeyChain.create(key: Token.githubAccessToken, token: githubAccessToken!)
                        requestToken.accept(true)
                    } else {
                        requestToken.accept(false)
                    }
                } else {
                    requestToken.accept(false)
                }
            case .failure(let error):
                print(error)
                requestToken.accept(false)
            }
        }.disposed(by: disposeBag)
        return requestToken
    }
    
    func checkGithubUser() -> PublishRelay<String> {
        let checkGithubUser = PublishRelay<String>()
        let parm = LoginRequest.init(KeyChain.read(key: Token.githubAccessToken) ?? "")
        print(KeyChain.read(key: Token.gituhbCode) ?? "")
        API.checkGithubUser(parm).request().subscribe { event in
            switch event {
            case .success(let response):
                print(response.data)
                guard let data = try? JSONDecoder().decode(CheckGithubUser.self, from: response.data) else {
                    checkGithubUser.accept("error")
                    return
                }
                if data.isAlreadyJoined == true {
                    checkGithubUser.accept("true")
                } else {
                    checkGithubUser.accept("false")
                }
            case .failure(let error):
                print(error)
                checkGithubUser.accept("error")
            }
        }.disposed(by: disposeBag)
        
        return checkGithubUser
    }
    
    func login() -> PublishRelay<Bool> {
        let loginSuccess = PublishRelay<Bool>()
        let parm = LoginRequest.init(KeyChain.read(key: Token.githubAccessToken) ?? "")
        API.login(parm).request().subscribe { event in
            switch event {
            case .success(let response):
                print(response.data)
                guard let data = try? JSONDecoder().decode(TokenResponse.self, from: response.data) else {
                    loginSuccess.accept(false)
                    return
                }
                KeyChain.create(key: Token.accessToken, token: data.accessToken)
                KeyChain.create(key: Token.refreshToken, token: data.refreshToken)
                loginSuccess.accept(true)
            case .failure(let error):
                print(error)
                loginSuccess.accept(false)
            }
        }.disposed(by: disposeBag)
        
        return loginSuccess
    }
    
    func postReissue() -> PublishRelay<Bool> {
        let postReissue = PublishRelay<Bool>()
        let parm = TokenResponse.init(
            accessToken: KeyChain.read(key: Token.accessToken)!,
            refreshToken: KeyChain.read(key: Token.refreshToken)!)
        API.reissue(parm).request().subscribe { evnt in
            switch evnt {
            case .success(let response):
                guard let data = try? JSONDecoder().decode(TokenResponse.self, from: response.data) else {
                    postReissue.accept(false)
                    return
                }
                KeyChain.create(key: Token.accessToken, token: data.accessToken)
                KeyChain.create(key: Token.refreshToken, token: data.refreshToken)
                print(parm)
                postReissue.accept(true)
            case .failure(_): postReissue.accept(false)
            }
        }.disposed(by: disposeBag)
        return postReissue
    }
    
    func goMainHome() {
        let mainViewController = TabBarController()
        mainViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        LoginVC().present(mainViewController, animated: true)
    }
    
    func goLogin() {
        LoginVC().navigationController?.pushViewController(SignInVC(), animated: true)
    }
    
}
