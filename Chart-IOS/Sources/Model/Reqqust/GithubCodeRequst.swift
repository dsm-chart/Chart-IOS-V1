//
//  GithubCodeRequst.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/29.
//

import Foundation

struct GithubCodeRequst: Codable {
    
    var clientId: String
    var clientSecret: String
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case code
    }
}
