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

    case postQuestion(_ questionRequest: QuestionRequest)
    case getQuestion(_ idx: Int, _ size: Int)

    // question-controller

    case postComment(_ commentRequest: CommentRequest)
    case getComment(_ postId: String)

    // account-controller

    case signUp(_ signUpRequet: SignUpRequet)
    case reissue(_ token: String)
    case login(_ loginRequest: LoginRequest)
    case myAuth

    // timetable-controller

    case getTimeTable(_ start: Int, _ end: Int)

    // cafeteria-controller

    case getMeal
    
    // neis API
    
    case getSchoolId(_ search: String)
    
    // Github API
    
    case postGithubCode(_ githubRequst: GithubCodeRequst)
    
    case checkGithubUser(_ loginRequest: LoginRequest)

}

extension API: Moya.TargetType {
    var baseURL: URL { self.getBaseURL() }
    var path: String { self.getPath() }
    var method: Moya.Method { self.getMethod() }
    var sampleData: Data { Data() }
    var task: Task { return getTask() }
    var headers: [String : String]? { return getHeader() }
}
