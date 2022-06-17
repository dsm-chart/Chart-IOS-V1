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
    }
    
    enum Mutation {
        case setTitle
        case setContent
        case setLoading(Bool)
    }
    
    struct State {
        var title = ""
        var content = ""
    }

}
