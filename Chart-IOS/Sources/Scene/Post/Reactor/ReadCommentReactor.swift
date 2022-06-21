//
//  ReadCommentReactor.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/20.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import SPIndicator

class ReadCommentReactor: Reactor {
    
    var initialState = State(list: [])
    let disposeBag: DisposeBag = .init()
    
    enum Action {
        case viewDidLoad
        case refreshList
    }
    
    enum Mutation {
        case getCommentList([Comment])
        case setLoading(Bool)
    }
    
    struct State {
        var list: [Comment]
        var isLoading = false
    }
    
}

// MARK: - Mutate
extension ReadCommentReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let getPostList = getCommentList().map { list -> Mutation in
                return .getCommentList(list)
            }
            return getPostList
        case .refreshList:
            return .concat([
                getCommentList().map { list -> Mutation in
                    return .getCommentList(list)
                },
                .just(.setLoading(false))
            ])
        }
    }
    
}

// MARK: - Reduce
extension ReadCommentReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .getCommentList(questionData):
            newState.list = questionData
        case let .setLoading(bool):
            newState.isLoading = bool
        }
        return newState
    }
}

// MARK: - Function
extension ReadCommentReactor {
    func getCommentList() -> PublishRelay<[Comment]> {
        let question = PublishRelay<[Comment]>()
        API.getQuestion(0, 100).request().subscribe { event in
            switch event {
            case .success(let response):
                if let data = try? JSONDecoder().decode(CommentArr.self, from: response.data) {
                    question.accept(data.data)
                }
            case .failure(_):
                SPIndicator.present(title: "Error!!", haptic: .error)
            }
        }.disposed(by: disposeBag)
        return question
    }
}
