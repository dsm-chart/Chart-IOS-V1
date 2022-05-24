//
//  API.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/24.
//

import Foundation
import Moya

enum API {

    // question-controller

    case postQuestion(_ title: String, _ content: String)
    case getQuestion(_ idx: Int, _ size: Int)

    // question-controller

    case postComment(_ content: String, _ targetId: String)
    case deleteComment(_ commentId: String)
    case patchComment(_ content: String, _ targetId: String)

    // account-controller

    case signUp
    case reissue
    case login(_ githubCode: String)
    case myAuth

    // timetable-controller

    case getTimeTable(_ start: Int, _ end: Int)
    case todayTimeTable

    // cafeteria-controller

    case getMeal

}
