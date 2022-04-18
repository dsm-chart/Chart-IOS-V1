//
//  SchoolMealVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit

class SchoolMealVC: BaseViewController {
    
    private let breakfastView = UIView()
    private let lunchView = UIView()
    private let dinnerView = UIView()
    
    private let breakfastNameLabel = UILabel()
    private let lunchNameLabel = UILabel()
    private let dinnerNameLabel = UILabel()

    
    func makeMealView() {
        [breakfastView, lunchView, dinnerView].forEach {
            $0.backgroundColor = Asset.viewColor.color
            $0.layer.cornerRadius = 20
        }
        
        [breakfastNameLabel, lunchNameLabel, dinnerNameLabel].forEach {
            $0.textColor = Asset.mainColor.color
            $0.font = .roundedFont(ofSize: 15, weight: .semibold)
        }

    }
    
    func addSubView() {
        
        let mealName =  ["아침", "점심", "저녁"]
        
        let mealViewArray = [breakfastView, lunchView, dinnerView]
        let mealNameLabelArray = [breakfastNameLabel, lunchNameLabel, dinnerNameLabel]
        
        for count in 0..<3 {
            mealNameLabelArray[count].text = mealName[count]
            view.addSubview(mealViewArray[count])
            mealViewArray[count].addSubview(mealNameLabelArray[count])
            
        }
    }
    
    override func configureUI() {
        makeMealView()
        addSubView()
    }
    
    override func setupConstraints() {
        
        [breakfastView, lunchView, dinnerView].forEach { view in
            view.snp.makeConstraints {
                $0.height.equalTo(140)
                $0.left.right.equalTo(self.view).inset(35)
            }
        }
        lunchView.snp.makeConstraints { $0.centerY.centerX.equalTo(view) }
        breakfastView.snp.makeConstraints {
            $0.bottom.equalTo(self.lunchView.snp.top).offset(-25)
        }
        dinnerView.snp.makeConstraints {
            $0.top.equalTo(self.lunchView.snp.bottom).offset(25)
        }
        
        [breakfastNameLabel, lunchNameLabel, dinnerNameLabel].forEach { label in
            label.snp.makeConstraints {
                $0.top.left.equalTo(15)
                $0.height.equalTo(20)
            }
        }
        
    }
    
}
