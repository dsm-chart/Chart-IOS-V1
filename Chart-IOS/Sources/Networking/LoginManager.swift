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

class LoginManager {
    
    static let shared = LoginManager()
    private let disposeBag = DisposeBag()
    
    private init() {}

    func requestAccessToken(with code: String) {
        let parm = GithubCodeRequst.init(code)
        API.postGithubCode(parm).request().subscribe { event in
            switch event {
            case .success(let response):
                if let json = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any] {
                    if let dic = json as? [String: String] {
                        let githubAccessToken = dic["access_token"]
                        print(githubAccessToken ?? "")
                        KeyChain.create(key: Token.githubAccessToken, token: githubAccessToken!)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }.disposed(by: disposeBag)
    }
    
}
