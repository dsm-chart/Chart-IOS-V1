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
        case getList([Question])
        case setLoading(Bool)
    }
    struct State {
        var list: [Question]
        var isLoading = false

    }
     
}

// MARK: - Mutate
extension MainPostReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .concat([
                .just(.setLoading(true)),
                getPostList().map { list -> Mutation in
                    return .getList(list)
                },
                .just(.setLoading(false))
            ])
        case .refreshList:
            return .concat([
                .just(.setLoading(true)),
                getPostList().map { list -> Mutation in
                    return .getList(list)
                },
                .just(.setLoading(false))
            ])
        }
    }
    
}

// MARK: - Function

extension MainPostReactor {
    func getPostList() -> PublishRelay<[Question]> {
        let question = PublishRelay<[Question]>()
        API.getQuestion(1, 20).request().subscribe { event in
            switch event {
            case .success(let response):
                if let data = try? JSONDecoder().decode([Question].self, from: response.data) {
                    question.accept(data)
                }
            case .failure(_):
                SPIndicator.present(title: "Error!!", haptic: .error)
            }
        }.disposed(by: disposeBag)
        return question
    }
}
