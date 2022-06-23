//
//  QuestionResponse.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/25.
//

import Foundation

struct QuestionResponse: Codable {
    let content: [QuestionData]
}

struct QuestionData: Codable {
    let id: String
    let title: String
    let content: String
    let writer: User
}
