//
//  SearchSchoolResponse.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/01.
//

import Foundation

// MARK: - Welcome
struct SearchSchoolResponse: Codable {
    let schoolInfo: [SchoolInfo]
}

// MARK: - SchoolInfo
struct SchoolInfo: Codable {
    let head: [Head]?
    let row: [[String: String?]]?
}

// MARK: - Head
struct Head: Codable {
    let listTotalCount: Int?
    let result: Result?

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case result = "RESULT"
    }
}

// MARK: - Result
struct Result: Codable {
    let code, message: String
    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
}

struct SearchRow: Codable {
    
    let areaCode: String
    let schoolCode: String
    let schoolName: String
    let areaName: String
    
    enum CodingKeys: String, CodingKey {
        case areaCode = "ATPT_OFCDC_SC_CODE"
        case schoolCode = "SD_SCHUL_CODE"
        case schoolName = "SCHUL_NM"
        case areaName = "ORG_RDNMA"
    }
    
}
