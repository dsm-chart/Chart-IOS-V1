//
//  MyInfoResponse.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/25.
//

import Foundation

struct MyInformation: Codable {
    
    let name, id, bio, githubID: String
    let createdAt, updatedAt: String
    let questionList: [QuestionList]
    
    enum CodingKeys: String, CodingKey {
        case name, id, bio
        case githubID = "githubId"
        case createdAt, updatedAt, questionList
    }
}

struct QuestionList: Codable {
    let title: String
    let content: String
}
