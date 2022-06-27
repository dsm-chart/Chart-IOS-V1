//
//  AddCommentReactor.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/23.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import SPIndicator

class AddCommentReactor: Reactor {
    var initialState = State()
    let disposeBag: DisposeBag = .init()
    
    enum Action {
        case postButtonClicked(String, String)
    }
    
    enum Mutation {
        case postComment
    }
    
    struct State {}
}

// MARK: - Mutate
extension AddCommentReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .postButtonClicked(postId, content):
            return postComment(postId: postId, content: content)
                .map { bool -> Mutation in return .postComment }
        }
    }
}

// MARK: - Function

extension AddCommentReactor {
    func postComment(postId: String, content: String) -> PublishRelay<Bool> {
        let bool = PublishRelay<Bool>()
        let parm = CommentRequest(content: content, targetId: postId)
        
        API.postComment(parm).request().subscribe { event in
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
