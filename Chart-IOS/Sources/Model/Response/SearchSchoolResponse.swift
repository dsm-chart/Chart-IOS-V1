//
//  SearchSchoolResponse.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/01.
//

import Foundation

// MARK: - Welcome
struct SearchSchoolResponse: Codable {
    let code, name, areaCode, addressCode: String
    let homePage, telephone, kind: String
}
