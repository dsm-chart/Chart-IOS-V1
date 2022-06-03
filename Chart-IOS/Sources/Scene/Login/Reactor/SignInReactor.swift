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
import SPIndicator
import SPAlert

final class SignInReactor: Reactor {
    
    let initialState = State(schoolClass: 0, scholNumber: 0, schoolCode: "", schoolName: "", areaCode: "", nextVC: UIViewController())
    private let disposeBag: DisposeBag = .init()
    
    enum Action {
        case updateAreaCode(String)
        case updateSchoolCode(String)
        case updateSchoolClass(Int)
        case updateSchoolNumber(Int)
        case searchSchoolDidTap
        case signUpButtonDidTap
    }
    
    enum Mutation {
        case setSchoolClass(Int)
        case setSchoolNumber(Int)
        case setSchoolCode(String)
        case setAreaCode(String)
        case goSchoolSearchView
        case signUp
    }
    
    struct State {
        var schoolClass: Int
        var scholNumber: Int
        var schoolCode: String
        var schoolName: String
        var areaCode: String
        var nextVC: UIViewController
    }
}

// MARK: - Mutate
extension SignInReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateSchoolClass(scClass):
            return .just(.setSchoolClass(scClass))
        case let .updateSchoolNumber(scNumber):
            return .just(.setSchoolNumber(scNumber))
        case .searchSchoolDidTap:
            return .empty()
        case .signUpButtonDidTap:
            return .just(.signUp)
        case let .updateAreaCode(code):
            return .just(.setAreaCode(code))
        case let .updateSchoolCode(code):
            return .just(.setAreaCode(code))
        }
    }
}

// MARK: - Reduce
extension SignInReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setSchoolClass(scClass):
            newState.schoolClass = scClass
        case let .setSchoolNumber(scNumber):
            newState.scholNumber = scNumber
        case .goSchoolSearchView:
            newState.nextVC = SearchSchoolVC()
        case .signUp:
            let signupParm = SignUpRequet(
                areaCode: state.areaCode,
                accessToken: KeyChain.read(key: Token.githubAccessToken) ?? "",
                schoolCode: state.schoolCode,
                grade: state.schoolClass,
                classNum: state.scholNumber)
            API.signUp(signupParm).request().subscribe { event in
                switch event {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode(TokenResponse.self, from: response.data) else {
                        SPIndicator.present(title: "파싱 애러!", preset: .error)
                        return
                    }
                    SPAlert.present(title: "회원가입 성공", preset: .error)
                    KeyChain.create(key: Token.accessToken, token: data.accessToken)
                    KeyChain.create(key: Token.refreshToken, token: data.refreshToken)
                case .failure(let error):
                    print(error)
                    SPAlert.present(title: "회원가입 실패", preset: .error)
                }
            }.disposed(by: disposeBag)
        case let .setSchoolCode(code):
            newState.schoolCode = code
        case let .setAreaCode(code):
            newState.areaCode = code
        }
        return newState
    }
}
