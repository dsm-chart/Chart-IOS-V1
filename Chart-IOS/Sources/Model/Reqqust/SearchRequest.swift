//
//  SearchRequest.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/09.
//

import Foundation

struct SearchRequest: Codable {
    let school: String
    init(_ school: String) {
        self.school = school
    }
}
