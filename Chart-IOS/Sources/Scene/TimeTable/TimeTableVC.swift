//
//  TimeTableVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit
import ReactorKit

class TimeTableVC: BaseViewController, View {
    
    let reactor = TimeTableReactor()
    
    private let semesterBackView = UILabel().then { $0.backgroundColor = .clear }
    
    private let backLine1 = UIView()
    private let backLine2 = UIView()
    private let semesterLabel = UILabel().then {
        $0.textColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let classNameLabel = UILabel().then {
        $0.textColor = Asset.labelColor.color
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let schoolTimeTableView = UIView().then {
        $0.backgroundColor = Asset.viewColor.color
        $0.layer.cornerRadius = 20
    }
    
    private let periodNumberStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
    }
    
    private let dayStringStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
    }
    
    private let timeTableStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
    }
    
    private let mondayStackView = UIStackView()
    private let tuesdayStackView = UIStackView()
    private let wednesdayStackView = UIStackView()
    private let thursdayStackView = UIStackView()
    private let fridayStackView = UIStackView()
    
    override func configureUI() {
        
        [backLine1, backLine2].forEach { $0.backgroundColor = Asset.mainColor.color }
        
        [semesterBackView, schoolTimeTableView].forEach {
            view.addSubview($0)
        }
        [semesterLabel, classNameLabel].forEach {
            semesterBackView.addSubview($0)
        }
        
        [backLine1, backLine2, periodNumberStackView, dayStringStackView, timeTableStackView].forEach {
            schoolTimeTableView.addSubview($0)
        }
        
        /// dummy Data
        semesterLabel.text = "0000년 X학기"
        classNameLabel.text = "0-0 시간표"
        makeStackView()
        bind(reactor: reactor)
    }
    
    private func makeStackView() {
        
        let periodArray = ["월", "화", "수", "목", "금"]
        
        for number in 0..<5 {
            let periodLabel = UILabel().then {
                $0.textAlignment = .center
                $0.font = .systemFont(ofSize: 18, weight: .bold)
                $0.textColor = .separator
                $0.text = "\(periodArray[number])"
            }
            dayStringStackView.addArrangedSubview(periodLabel)
        }
        
        for number in 1..<8 {
            let dayLabel = UILabel().then {
                $0.textAlignment = .center
                $0.font = .systemFont(ofSize: 18, weight: .bold)
                $0.textColor = .separator
                $0.text = "\(number)"
            }
            periodNumberStackView.addArrangedSubview(dayLabel)
        }
        
    }
    
    func bind(reactor: TimeTableReactor) {
        rx.viewDidAppear.distinctUntilChanged().map { _ in Reactor.Action.viewDidLoad }.bind(to: reactor.action).disposed(by: disposeBag)
        
        reactor.state.map { $0.timeTable }.filter { $0.isEmpty == false }.bind { timeTable in
            let weekStackViewArray = [self.mondayStackView, self.tuesdayStackView,
                                      self.wednesdayStackView, self.thursdayStackView, self.fridayStackView]
            print(timeTable)
            for weekNumber in 0..<timeTable.count {
                for dayNumber in 0..<7 {
                    let weekArr = timeTable[weekNumber]
                    let label = UILabel().then {
                        $0.textColor = Asset.labelColor.color
                        $0.text = "\(weekArr.subjects[dayNumber].name)"
                        $0.textAlignment = .center
                    }
                    weekStackViewArray[weekNumber].addArrangedSubview(label)
                }
            }
            weekStackViewArray.forEach {
                $0.distribution = .fillEqually
                $0.axis = .vertical
                self.timeTableStackView.addArrangedSubview($0)
            }
        }
        .disposed(by: disposeBag)
    }
    
    override func setupConstraints() {
        
        semesterBackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(schoolTimeTableView.snp.top)
        }
        
        semesterLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(classNameLabel.snp.top)
        }
        
        classNameLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(semesterBackView).offset(20)
        }
        
        schoolTimeTableView.snp.makeConstraints {
            $0.height.equalTo(469)
            $0.left.right.equalTo(self.view).inset(35)
            $0.centerY.centerX.equalTo(view)
        }
        
        backLine1.snp.makeConstraints {
            $0.left.equalTo(50)
            $0.top.bottom.equalTo(schoolTimeTableView).inset(20)
            $0.width.equalTo(1)
        }
        
        backLine2.snp.makeConstraints {
            $0.left.right.equalTo(schoolTimeTableView).inset(20)
            $0.top.equalTo(55)
            $0.height.equalTo(1)
        }
        
        periodNumberStackView.snp.makeConstraints {
            $0.right.equalTo(backLine1)
            $0.top.equalTo(backLine2)
            $0.bottom.equalTo(-20)
            $0.width.equalTo(30)
        }
        
        dayStringStackView.snp.makeConstraints {
            $0.left.equalTo(50)
            $0.right.equalTo(-20)
            $0.height.equalTo(35)
            $0.bottom.equalTo(backLine2)
        }
        
        timeTableStackView.snp.makeConstraints {
            $0.top.equalTo(backLine2)
            $0.right.equalTo(backLine2.snp.right)
            $0.left.equalTo(backLine1)
            $0.bottom.equalTo(backLine1.snp.bottom)
        }
        
    }
}
