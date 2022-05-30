//
//  TokenResponse.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/30.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
