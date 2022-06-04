//
//  SearchSchoolReactor.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/02.
//

import Foundation
import ReactorKit
import SPIndicator

class SearchSchoolReactor: Reactor {
    
    let initialState = State(schoolList: [])
    private let signUpVC = SignInVC()
    private let disposeBag: DisposeBag = .init()
    
    enum Action {
        case searchSchool(String)
        case selectView(IndexPath)
    }
    enum Mutation {
        case getSchoolList(String)
        case setSchoolInfo(IndexPath)
    }
    
    struct State {
        var schoolList: [SearchRow]
    }
    
}

// MARK: - Mutate
extension SearchSchoolReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .searchSchool(search):
            return.just(.getSchoolList(search))
        case let .selectView(indexPath):
            return .just(.setSchoolInfo(indexPath))
        }
    }
}

// MARK: - Reduce
extension SearchSchoolReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .getSchoolList(search):
            API.getSchoolId(search).request().subscribe { event in
                switch event {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode(SearchSchoolResponse.self, from: response.data) else {
                        SPIndicator.present(title: "파싱 애러!", preset: .error)
                        return
                    }
                    newState.schoolList = data.schoolInfo[1].row ?? []
                case .failure(let error):
                    print(error)
                    SPIndicator.present(title: "Network 애러!", preset: .error)
                }
            }.disposed(by: disposeBag)
            
        case let .setSchoolInfo(indexPath):
            signUpVC.searchedAreaCode.accept(state.schoolList[indexPath.row].areaCode)
            signUpVC.searchedSchoolCode.accept(state.schoolList[indexPath.row].schoolCode)
            signUpVC.searchedSchoolName.accept(state.schoolList[indexPath.row].schoolName)
        }
        return newState
    }
}
