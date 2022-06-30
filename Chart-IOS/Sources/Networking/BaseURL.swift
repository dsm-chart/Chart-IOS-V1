//
//  BaseURL.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/24.
//

import Foundation

struct Base {
    static let baseURL = "http://118.67.130.149:8080"
    static let neisURL = "https://open.neis.go.kr"
    static let neisApiKey = Bundle.main.object(forInfoDictionaryKey: "neisApiKey") as? String
    static let githubURL = "https://github.com"
    static let githubScope = "repo,user"
    static let githubClientId = Bundle.main.object(forInfoDictionaryKey: "githubClientId") as! String
    static let clientSecret = Bundle.main.object(forInfoDictionaryKey: "clientSecret") as! String
}
