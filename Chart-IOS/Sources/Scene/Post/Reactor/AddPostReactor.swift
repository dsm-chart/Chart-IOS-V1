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
        case postButtonClicked(String, String)
    }
    
    enum Mutation {
        case postQuestion
    }
    
    struct State {}

}

// MARK: - Mutate
extension AddPostReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .postButtonClicked(title, content):
            return postQuestion(title: title, content: content)
                .map { bool -> Mutation in return .postQuestion }
        }
    }
}

// MARK: - Function

extension AddPostReactor {
    func postQuestion(title: String, content: String) -> PublishRelay<Bool> {
        let bool = PublishRelay<Bool>()
        let parm = QuestionRequest(title: title, content: content)
        
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
