//
//  UserResponse.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/25.
//

import Foundation

struct User: Codable {
    let githubId: String
    let name: String?
    let bio: String?
}
