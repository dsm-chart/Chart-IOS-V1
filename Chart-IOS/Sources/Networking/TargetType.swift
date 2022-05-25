//
// Created by 김대희 on 2022/05/24.
//

import Foundation
import Moya

extension API {

    func getBaseURL() -> URL {
        return URL(string: baseURL)!
    }

    func getPath() -> String {
        switch self {
        case .postQuestion(_, _), .getQuestion(_, _):
            return "/api/v1/question"
        case .postComment(_, _):
            return "/api/v1/comment"
        case .getComment(let postId):
            return "/api/v1/comment/\(postId)"
        case .signUp:
            return "/api/v1/auth/signup"
        case .reissue:
            return "/api/v1/auth/reissue"
        case .login(_):
            return "/api/v1/auth/login"
        case .myAuth:
            return "/api/v1/auth/my"
        case .getTimeTable(_, _):
            return "/api/v1/timetable"
        case .todayTimeTable:
            return "/api/v1/timetable/today"
        case .getMeal:
            return "/api/v1/meal"
        }
    }

    func getMethod() -> Moya.Method {
        switch self {
        case .postQuestion(_, _), .postComment(_, _), .signUp, .reissue, .login(_):
            return .post
        case .getQuestion(_, _), .getComment(_), .myAuth, .getTimeTable(_, _), .todayTimeTable, .getMeal:
            return .get
        }
    }
}
