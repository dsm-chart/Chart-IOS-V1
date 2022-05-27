//
//  TimeTableResponse.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/25.
//

import Foundation

struct TimeTable: Codable {
    let data: [DayTimeTable]
}

struct DayTimeTable: Codable {
    let grade: Int
    let classNum: Int
    let totalCount: Int
    let day: Int
    let subjects: [Subjects]
}

struct Subjects: Codable {
    let name: String
    let period: Int
}
