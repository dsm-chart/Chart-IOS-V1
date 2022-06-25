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

