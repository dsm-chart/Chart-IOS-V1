//
//  PostReactor.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/13.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import SPIndicator

class MainPostReactor: Reactor {
    
    var initialState = State(list: [])
    let disposeBag: DisposeBag = .init()
    
    enum Action {
        case viewDidLoad
        case refreshList
    }
    enum Mutation {
        case getList([QuestionData])
        case setLoading(Bool)
    }
    struct State {
        var list: [QuestionData]
        var isLoading = false
        
    }
    
}

// MARK: - Mutate
extension MainPostReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let getPostList = getPostList().map { list -> Mutation in
                return .getList(list)
            }
            return getPostList
        case .refreshList:
            return .concat([
                getPostList().map { list -> Mutation in
                    return .getList(list)
                },
                .just(.setLoading(false))
            ])
        }
    }
    
}

// MARK: - Reduce
extension MainPostReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .getList(questionData):
            newState.list = questionData
        case let .setLoading(bool):
            newState.isLoading = bool
        }
        return newState
    }
}

// MARK: - Function

extension MainPostReactor {
    func getPostList() -> PublishRelay<[QuestionData]> {
        let question = PublishRelay<[QuestionData]>()
        API.getQuestion(0, 100).request().subscribe { event in
            switch event {
            case .success(let response):
                if let data = try? JSONDecoder().decode(QuestionResponse.self, from: response.data) {
                    question.accept(data.content)
                }
            case .failure(_):
                SPIndicator.present(title: "로딩에 실페했어요!", haptic: .error)
                question.accept([])
            }
        }.disposed(by: disposeBag)
        return question
    }
}
