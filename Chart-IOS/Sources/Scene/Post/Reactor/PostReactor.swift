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

class PostReactor: Reactor {
    
    
    
    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case getList([Question])
    }
    struct State {
        var list: [Question]
    }

}

