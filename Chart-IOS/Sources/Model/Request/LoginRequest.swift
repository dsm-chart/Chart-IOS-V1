//
//  LoginRequest.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/25.
//

import Foundation

struct LoginRequest: Codable {
    var accessToken: String
    init( _ accessToken: String) {
        self.accessToken = accessToken
    }
}
