//
//  SettingReactor.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/07/01.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import SPIndicator

class SettingReactor: Reactor {

        let initialState = State()
        private let disposeBag: DisposeBag = .init()

        enum Action {
            case viewDidLoad
        }
        enum Mutation {
            case getUserInfo(String, [QuestionData])
        }
        struct State {
            var userName: String = ""
            var myList: [QuestionData] = []
        }
}

// MARK: - Mutate
extension SettingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return getUserInfo().map { userInfo -> Mutation in
                return .getUserInfo(userInfo.name, userInfo.questionList)
            }
        }
    }
}
// MARK: - Reduce
extension  SettingReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .getUserInfo(userName, myList):
            newState.userName = userName
            newState.myList = myList
        }
        return newState
    }
}
// MARK: - Function
extension  SettingReactor {
    func getUserInfo() -> PublishRelay<MyInformation> {
        let userInfo = PublishRelay<MyInformation>()
        API.myAuth.request().subscribe { event in
            switch event {
            case .success(let response):
                if let data = try? JSONDecoder().decode(MyInformation.self, from: response.data) {
                    userInfo.accept(data)
                }
            case .failure(_): break
            }
        }.disposed(by: disposeBag)
        return userInfo
    }
}
