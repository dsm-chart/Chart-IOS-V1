//
//  SiginInDoneVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/27.
//

import UIKit
import BEMCheckBox

class SiginInDoneVC: BaseViewController {
    
    private let doneBox = BEMCheckBox().then {
        $0.tintColor = .clear
        $0.onFillColor = .clear
        $0.onCheckColor = Asset.mainColor.color
        $0.onTintColor = Asset.mainColor.color
        $0.offAnimationType = .bounce
        $0.onAnimationType = .bounce
        $0.boxType = .circle
        $0.lineWidth = 10
        $0.animationDuration = 1
    }
    
    private let doneTextLabel = UILabel().then {
        $0.text = "회원가입이 성공적으로 완료되었어요"
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .clear
    }
    
    private let maskView = UIView()
    private let goHomeButton = UIButton()
    
    override func configureUI() {
        
        maskView.backgroundColor = .clear
        goHomeButton.makeMyDesign(color: Asset.mainColor.color, title: "첫 화면으로 돌아가기", titleColor: .white)
        [doneBox, goHomeButton, maskView, doneTextLabel].forEach {
            view.addSubview($0)
        }
        
    }
    
    override func setupConstraints() {
        
        maskView.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view).offset(-130)
            
        }
        doneBox.snp.makeConstraints {
            $0.width.height.equalTo(150)
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view).offset(-130)
        }
        
        goHomeButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(15)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
        }
        
        doneTextLabel.snp.makeConstraints {
            $0.top.equalTo(doneBox.snp.bottom).offset(30)
            $0.centerX.equalTo(view)
            $0.height.equalTo(40)
        }
        
    }
    
    override func setLayout() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.doneBox.setOn(true, animated: true)
            
            UIView.transition(with: self.doneTextLabel,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                self?.doneTextLabel.textColor = Asset.labelColor.color
            }, completion: nil)

        }
    }
    
}
