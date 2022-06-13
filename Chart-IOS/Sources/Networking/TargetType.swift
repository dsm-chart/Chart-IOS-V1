//
// Created by 김대희 on 2022/05/24.
//

import Foundation
import Moya
import Then

extension API {
    
    func getBaseURL() -> URL {
        switch self {
        case .postGithubCode(_):
            return URL(string: Base.githubURL)!
        default:
            return URL(string: Base.baseURL)!
        }
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
        case .getSchoolId(_):
            return "/api/v1/school"
        case .postGithubCode(_):
            return "/login/oauth/access_token"
        case .checkGithubUser(_):
            return "/api/v1/auth/check"
        }
    }
    
    func getMethod() -> Moya.Method {
        switch self {
        case .postQuestion(_), .postComment(_), .signUp, .reissue, .login(_), .postGithubCode(_), .getSchoolId(_):
            return .post
        case .getQuestion(_, _), .getComment(_), .myAuth, .getTimeTable(_, _), .getMeal:
            return .get
        case .checkGithubUser(_):
            return .put
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
        case .login(let loginRequest), .checkGithubUser(let loginRequest):
            return .requestJSONEncodable(loginRequest)
        case .postGithubCode(let githubRequst):
            return .requestJSONEncodable(githubRequst)
        case .reissue(let tokenRespust):
            return .requestJSONEncodable(tokenRespust)
        case .getSchoolId(let search):
            return .requestParameters(parameters: ["school" : search], encoding: URLEncoding.queryString)
        case .getMeal:
            let dateFormatter = DateFormatter()
            let date = Date()
            dateFormatter.dateFormat = "YYYYMMdd" // set
            return .requestParameters(parameters: ["date" : "\(dateFormatter.string(from: date))"], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    func getHeader() -> [String : String] {
        switch self {
        case .signUp(_), .reissue, .login(_), .getSchoolId(_), .checkGithubUser(_):
            return ["Content-Type" : "application/json"]
        case .postGithubCode(_):
            return ["Accept": "application/json"]
        default:
            return ["Authorization" : "Bearer \(KeyChain.read(key: Token.accessToken) ?? "")"]
        }
    }
}
