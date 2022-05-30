//
//  LoginRequest.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/25.
//

import Foundation

struct LoginRequest: Codable {
    var githubCode: String
    init( _ githubCode: String) {
        self.githubCode = githubCode
    }
}
