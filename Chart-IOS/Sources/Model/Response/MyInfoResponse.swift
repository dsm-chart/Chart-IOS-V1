//
//  MyInfoResponse.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/25.
//

import Foundation

struct MyInformation: Codable {
    let name: String
    let id: String
    let bio: String
    let githubId: String
    
    let createdAt: String
    let updatedAt: String
    
    let questionList: [QuestionData]
}
