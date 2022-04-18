//
//  SchoolMealVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit

class SchoolMealVC: BaseViewController {
    
    private let dateBackView = UILabel().then {
        $0.backgroundColor = .clear
    }
    
    private let dateLabel = UILabel().then {
        $0.textColor = Asset.mainColor.color
        $0.font = .roundedFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let mealTabelNameLabel = UILabel().then {
        $0.textColor = Asset.labelColor.color
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let breakfastView = UIView()
    private let lunchView = UIView()
    private let dinnerView = UIView()
    
    private let breakfastNameLabel = UILabel()
    private let lunchNameLabel = UILabel()
    private let dinnerNameLabel = UILabel()
    
    private let breakfastTextView = UITextView()
    private let lunchTextView = UITextView()
    private let dinnerTextView = UITextView()
    
    
    func makeMealView() {
        [breakfastView, lunchView, dinnerView].forEach {
            $0.backgroundColor = Asset.viewColor.color
            $0.layer.cornerRadius = 20
        }
        
        [breakfastNameLabel, lunchNameLabel, dinnerNameLabel].forEach {
            $0.textColor = Asset.mainColor.color
            $0.font = .roundedFont(ofSize: 15, weight: .semibold)
        }
        
        [breakfastTextView, lunchTextView, dinnerTextView].forEach {
            $0.textColor = Asset.labelColor.color
            $0.isEditable = false
            $0.font = .roundedFont(ofSize: 15, weight: .regular)
            $0.isSelectable = false
        }
        
    }
    
    func addSubView() {
        
        let mealName =  ["아침", "점심", "저녁"]
        
        view.addSubview(dateBackView)
        [dateLabel, mealTabelNameLabel].forEach { dateBackView.addSubview($0) }
        
        let mealViewArray = [breakfastView, lunchView, dinnerView]
        let mealNameLabelArray = [breakfastNameLabel, lunchNameLabel, dinnerNameLabel]
        let mealTextViewArray = [breakfastTextView, lunchTextView, dinnerTextView]
        
        for count in 0..<3 {
            mealNameLabelArray[count].text = mealName[count]
            view.addSubview(mealViewArray[count])
            mealViewArray[count].addSubview(mealNameLabelArray[count])
            mealViewArray[count].addSubview(mealTextViewArray[count])
        }
        
        //TODO: Dummy Data, 추후 추가 예정
        
        dateLabel.text = "0000-00-00"
        mealTabelNameLabel.text = "무요일 식단표"
        
    }
    
    override func configureUI() {
        makeMealView()
        addSubView()
    }
    
    override func setupConstraints() {
        dateBackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(breakfastView.snp.top)
        }
        
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(mealTabelNameLabel.snp.top)
        }
        
        mealTabelNameLabel.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(dateBackView).offset(20)
        }
        
        [breakfastView, lunchView, dinnerView].forEach { view in
            view.snp.makeConstraints {
                $0.height.equalTo(140)
                $0.left.right.equalTo(self.view).inset(35)
            }
        }
        
        lunchView.snp.makeConstraints { $0.centerY.centerX.equalTo(view) }
        breakfastView.snp.makeConstraints { $0.bottom.equalTo(self.lunchView.snp.top).offset(-25) }
        dinnerView.snp.makeConstraints { $0.top.equalTo(self.lunchView.snp.bottom).offset(25) }
        
        [breakfastNameLabel, lunchNameLabel, dinnerNameLabel].forEach { label in
            label.snp.makeConstraints {
                $0.top.left.equalTo(15)
                $0.height.equalTo(20)
            }
        }
        
        [breakfastTextView, lunchTextView, dinnerTextView].forEach { textView in
            textView.snp.makeConstraints {
                $0.right.bottom.equalTo(-15)
                $0.left.equalTo(15)
                $0.top.equalTo(40)
            }
            
        }
        
    }
    
}
