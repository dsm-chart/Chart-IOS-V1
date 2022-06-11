//
//  SearchSchoolReactor.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/06/02.
//

import Foundation
import ReactorKit
import SPIndicator
import RxRelay

class SearchSchoolReactor: Reactor {
    
    let initialState = State(schoolList: [])
    private let signUpVC = SignInVC()
    private let disposeBag: DisposeBag = .init()
    
    enum Action {
        case searchSchool(String)
        case selectView(Int)
    }
    enum Mutation {
        case getSchoolList([SearchSchoolResponse])
        case setSchoolInfo(Int)
    }
    
    struct State {
        var schoolList: [SearchSchoolResponse]
    }
    
}

// MARK: - Mutate
extension SearchSchoolReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .searchSchool(search):
            let  getSchoolList = getSchoolId(search: search).asObservable().map { list -> Mutation in
                return .getSchoolList(list)
            }
            return getSchoolList
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
        case let .getSchoolList(list):
            newState.schoolList = list
        case let .setSchoolInfo(indexPath):
            signUpVC.searchedAreaCode.accept(state.schoolList[indexPath].areaCode)
            signUpVC.searchedSchoolCode.accept(state.schoolList[indexPath].code)
            signUpVC.searchedSchoolName.accept(state.schoolList[indexPath].name)
        }
        return newState
    }
}

// MARK: - Funcion
extension SearchSchoolReactor {
    func getSchoolId(search: String) -> PublishRelay<[SearchSchoolResponse]> {
        let returnData = PublishRelay<[SearchSchoolResponse]>()
        API.getSchoolId(search).request()
            .subscribe(on: CurrentThreadScheduler.instance)
            .subscribe { event in
            switch event {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode([SearchSchoolResponse].self, from: response.data)
                    returnData.accept(data)
                } catch {
                    SPIndicator.present(title: "Pars 애러!", preset: .error)
                }
            case .failure(let error):
                print(error)
                SPIndicator.present(title: "검색결과 없슴", preset: .error)
            }
            }.disposed(by: disposeBag)
        return returnData
    }
}
