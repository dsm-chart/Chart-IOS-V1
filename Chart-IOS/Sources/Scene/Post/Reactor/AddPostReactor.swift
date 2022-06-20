//
//  AddPostReactor.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/16.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import SPIndicator

class AddPostReactor: Reactor {
    
    var initialState = State()
    let disposeBag: DisposeBag = .init()
    
    enum Action {
        case postButtonClicked
        case updateTitle(String)
        case updateContent(String)
    }
    
    enum Mutation {
        case setTitle(String)
        case setContent(String)
        case postQuestion(Bool)
    }
    
    struct State {
        var title = ""
        var content = ""
    }
    
}

// MARK: - Mutate
extension AddPostReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .postButtonClicked:
            let postQuestion = postQuestion(state: State()).map { bool -> Mutation in return .postQuestion(bool) }
            return postQuestion
        case .updateTitle(let title):
            return .just(.setTitle(title))
        case .updateContent(let content):
            return .just(.setContent(content))
        }
    }
}

// MARK: - Reduce
extension AddPostReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setTitle(title):
            newState.title = title
        case let .setContent(content):
            newState.content = content
        case .postQuestion: break
        }
        return newState
    }
}

// MARK: - Function

extension AddPostReactor {
    func postQuestion(state: State) -> PublishRelay<Bool> {
        let bool = PublishRelay<Bool>()
        let parm = QuestionRequest(title: state.title, content: state.content)
        
        API.postQuestion(parm).request().subscribe { event in
                switch event {
                case .success(_):
                    bool.accept(true)
                case .failure(_):
                    SPIndicator.present(title: "전송 실폐", haptic: .error)
                    bool.accept(false)
                }
        }.disposed(by: disposeBag)
        return bool
    }
}
