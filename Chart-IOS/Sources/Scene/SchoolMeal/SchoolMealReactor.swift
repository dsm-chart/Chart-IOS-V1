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

