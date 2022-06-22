//
//  TimeTableReactor.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/13.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import SPIndicator

class TimeTableReactor: Reactor {
    
    let initialState = State(timeTable: [])
    private let disposeBag: DisposeBag = .init()
    
    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case getTimeTable([TimeTable])
    }
    struct State {
        var timeTable: [TimeTable]
    }
}

// MARK: - Mutate
extension TimeTableReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return getTimeTable().map { timeTable -> Mutation in
                return .getTimeTable(timeTable)
            }
        }
    }
}

// MARK: - Reduce
extension TimeTableReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .getTimeTable(timeTable):
            newState.timeTable = timeTable
        }
        return newState
    }
}

// MARK: - Function

extension TimeTableReactor {
    func getTimeTable() -> PublishRelay<[TimeTable]> {
        let timeTable = PublishRelay<[TimeTable]>()
        API.getTimeTable.request().subscribe { event in
            switch event {
            case .success(let response):
                if let data = try? JSONDecoder().decode(TimeTableResponse.self, from: response.data) {
                    timeTable.accept(data.data)
                }
            case .failure(_):
                SPIndicator.present(title: "Error!!", haptic: .error)
            }
        }.disposed(by: disposeBag)
        return timeTable
    }
}
