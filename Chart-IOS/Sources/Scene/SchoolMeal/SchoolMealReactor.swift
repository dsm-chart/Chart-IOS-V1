//
//  SchoolMealReactor.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/13.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import SPIndicator

class SchoolMealReactor: Reactor {
    
    let initialState = State(schoolList: .init(breakfast: [], lunch: [], dinner: []))
    private let disposeBag: DisposeBag = .init()
    
    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case getSchoolMeal(Meal)
    }
    struct State {
        var schoolList: Meal
    }
}

// MARK: - Mutate
extension SchoolMealReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let  getSchoolMeal = getMeal().map { meal -> Mutation in
                return .getSchoolMeal(meal)
            }
            return getSchoolMeal
        }
    }
}

// MARK: - Reduce
extension SchoolMealReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .getSchoolMeal(meal):
            newState.schoolList = meal
        }
        return newState
    }
}

// MARK: - Function

extension SchoolMealReactor {
    func getMeal() -> PublishRelay<Meal> {
        let meal = PublishRelay<Meal>()
        API.getMeal.request().subscribe { event in
            switch event {
            case .success(let response):
                if let data = try? JSONDecoder().decode(Meal.self, from: response.data) {
                    meal.accept(data)
                }
            case .failure(_):
                SPIndicator.present(title: "Error!!", haptic: .error)
            }
        }.disposed(by: disposeBag)
        return meal
    }
}
