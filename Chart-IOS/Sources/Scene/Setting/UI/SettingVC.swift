//
//  SettingVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit
import ReactorKit
import RxRelay

class SettingVC: BaseViewController, View {
    
    let reactor = SettingReactor()
    var myList: [QuestionList] = []
    
    private let labelBackView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(SettingListCell.self, forCellReuseIdentifier: "settingListCell")
    }
    
    private let subTitleLabel = UILabel().then {
        $0.textColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = Asset.labelColor.color
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.textAlignment = .center
    }
    
    override func configureUI() {
        [labelBackView, tableView].forEach {
            view.addSubview($0)
        }
        
        [subTitleLabel, titleLabel].forEach {
            labelBackView.addSubview($0)
        }
        
        subTitleLabel.text = "OOO님 반가워요"
        titleLabel.text = "환경설정"
        
        bind(reactor: reactor)
        
    }
    
    override func setLayout() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func setupConstraints() {
        
        labelBackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(
                -(self.navigationController?.navigationBar.frame.height ?? 0.0))
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.centerY).offset(-234.5)
        }

        subTitleLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(titleLabel.snp.top)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(labelBackView).offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(labelBackView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func bind(reactor: SettingReactor) {
        
        rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .bind { text in
                if text == "최근 작성한 게시물" { self.goMyListVC() }
                else if text == "로그아웃" { self.logOut() }
            }.disposed(by: disposeBag)
        
        reactor.state
            .map { $0.userName }
            .bind { text in  self.subTitleLabel.text = "\(text)님 안녕하세요" }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.myList }
            .bind { list in self.myList = list }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.settingTitleArray }
            .bind(to: tableView.rx.items(
                cellIdentifier: "settingListCell",
                cellType: SettingListCell.self)) {(row, element: String, cell) in
                    cell.titleLabel.text = element
            }.disposed(by: disposeBag)
        
    }

    func goMyListVC() {
        let myPostVC = MyPostVC()
        myPostVC.myList = self.myList
        self.navigationController?.pushViewController(myPostVC, animated: true)
    }
    
    func logOut() {
        
        let alert = UIAlertController(
            title: "로그아웃 하실 건가요?",
            message: "자동 로그인 정보가 삭제되요.",
            preferredStyle: UIAlertController.Style.alert)
                
        let okAction = UIAlertAction(title: "OK", style: .default, handler : { _ in
            KeyChain.delete(key: Token.accessToken)
            KeyChain.delete(key: Token.refreshToken)
            let loginVC = BaseNavigationController(rootViewController: LoginVC())
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
        })
        
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler : nil)
        
        alert.view.tintColor = Asset.mainColor.color
        alert.addAction(cancel)
        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)

    }
    
}
