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
        case .postQuestion(_), .getQuestion(_, _):
            return "/api/v1/question"
        case .postComment(_):
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
        case .getMeal:
            return "/api/v1/meal"
        }
    }
    
    func getMethod() -> Moya.Method {
        switch self {
        case .postQuestion(_), .postComment(_), .signUp, .reissue, .login(_):
            return .post
        case .getQuestion(_, _), .getComment(_), .myAuth, .getTimeTable(_, _), .getMeal:
            return .get
        }
    }
    
    func getTask() -> Task {
        switch self {
        case .postQuestion(let questionRequest):
            return .requestJSONEncodable(questionRequest)
        case .postComment(let commentRequest):
            return .requestJSONEncodable(commentRequest)
        case .signUp(let signUpRequet):
            return .requestJSONEncodable(signUpRequet)
        case .login(let loginRequest):
            return .requestJSONEncodable(loginRequest)
        default:
            return .requestPlain
        }
    }
}
