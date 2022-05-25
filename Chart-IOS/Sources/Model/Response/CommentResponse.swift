//
//  CommentResponse.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/25.
//

import Foundation

struct Comment: Codable {
    let content: String
    let writer: User
}
