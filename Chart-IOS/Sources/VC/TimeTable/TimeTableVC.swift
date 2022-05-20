//
//  TimeTableVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit

class TimeTableVC: BaseViewController {

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
        
        /// dummy Data
        semesterLabel.text = "0000년 X학기"
        classNameLabel.text = "0-0 시간표"
        
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
        
    }
    
}
