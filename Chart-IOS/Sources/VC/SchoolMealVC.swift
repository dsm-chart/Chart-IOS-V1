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
    
    
    func makeMealView() {
        [breakfastView, lunchView, dinnerView].forEach {
            $0.backgroundColor = Asset.viewColor.color
            $0.layer.cornerRadius = 20
        }
    }
    
    func addSubView() {
        [breakfastView, lunchView, dinnerView].forEach {
            view.addSubview($0)
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
        
    }
    
}
