//
//  SignInReactor.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/31.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa

final class SignInReactor: Reactor {
    
    private let disposeBag: DisposeBag = .init()
    
    enum Action {
        case updateSchoolClass(Int)
        case updateSchoolNumber(Int)
        case searchSchoolDidTap(String)
        case signUpButtonDidTap
    }
    
    enum Mutation {
        case setSchoolClass(Int)
        case setSchoolNumber(Int)
        case getschoolList([SearchRow])
    }
    
    struct State  {
        var schoolClass: Int
        var scholNumber: Int
        var schoolCode: String
        var areaCode: String
    }
}
