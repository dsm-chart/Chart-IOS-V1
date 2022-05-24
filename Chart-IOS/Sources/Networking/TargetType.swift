//
// Created by 김대희 on 2022/05/24.
//

import Foundation

extension API {

    func getBaseURL() -> URL {
        return URL(string: baseURL)
    }

    func getPath() -> String {
        switch self {

        case .postQuestion(_, _), .getQuestion(_, _):
            return "/api/v1/question"
        case .postComment(_, _), .deleteComment(_), .patchComment(_, _):
            return "/api/v1/comment"
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


}
