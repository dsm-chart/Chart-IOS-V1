//
//  SignupRequest.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/25.
//

import Foundation

struct SignUpRequest: Codable {
    let areaCode: String
    let accessToken: String
    let schoolCode: String
    let grade: Int
    let classNum: Int
    
    init(areaCode: String, accessToken: String, schoolCode: String, grade: Int, classNum: Int) {
        self.areaCode = areaCode
        self.accessToken = accessToken
        self.schoolCode = schoolCode
        self.grade = grade
        self.classNum = classNum
    }
}
