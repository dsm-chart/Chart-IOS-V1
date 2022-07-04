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
