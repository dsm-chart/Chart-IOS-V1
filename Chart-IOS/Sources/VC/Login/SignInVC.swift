//
//  SignInVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/19.
//

import UIKit
import RxKeyboard
import RxGesture
import PanModal
import BEMCheckBox

class SignInVC: BaseViewController {
    
    private let signInNameLabbel = UILabel().then {
        $0.text = "Sign in"
        $0.textColor = Asset.labelColor.color
        $0.font = .roundedFont(ofSize: 35, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let signInDoneButton = UIButton()
    
    private let schoolNameTextField = UILabel().then {
        $0.text = "학교를 검색하세요"
        $0.font = .roundedFont(ofSize: 18, weight: .medium)
        $0.textColor = .separator
    }
    
    let schoolGradeTextField = UITextField()
    let schoolClassNumberTextField = UITextField()
    
    private let textFieldBackView1 = UIView()
    private let textFieldBackView2 = UIView()
    private let textFieldBackView3 = UIView()
    
    private let agreeLabel = UILabel().then {
        $0.text = "개인정보 처리방침 에 동의합니다."
        $0.font = .roundedFont(ofSize: 13, weight: .semibold)
        $0.textColor = Asset.labelColor.color
        $0.textAlignment = .left
    }
    
    private let agreeCheckBox = BEMCheckBox().then {
        $0.tintColor = .lightGray
        $0.onTintColor = Asset.mainColor.color
        $0.onFillColor = Asset.mainColor.color
        $0.onCheckColor = .white
        $0.offAnimationType = .fade
        $0.onAnimationType = .fade
        $0.boxType = .circle
        $0.lineWidth = 1
        $0.animationDuration = 0.3
    }

    func makeTextField() {
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.separator,
            NSAttributedString.Key.font: UIFont.roundedFont(ofSize: 18, weight: .medium)
        ]
        
        [schoolGradeTextField, schoolClassNumberTextField].forEach {
            $0.borderStyle = .none
            $0.font = .roundedFont(ofSize: 18, weight: .medium)
            $0.tintColor = Asset.mainColor.color
        }
        
        [textFieldBackView1, textFieldBackView2, textFieldBackView3].forEach {
            $0.backgroundColor = .clear
            $0.layer.borderColor = Asset.mainColor.color.cgColor
            $0.layer.borderWidth = 2
            $0.layer.cornerRadius = 10
        }
        
        schoolGradeTextField.attributedPlaceholder = NSAttributedString(string: "학년을 입력하세요 (ex : 1", attributes: attributes)
        schoolClassNumberTextField.attributedPlaceholder = NSAttributedString(string: "번호를 입력하세요 (ex : 01", attributes: attributes)
        
    }
    
    func makeAgreeText() {
        
        let attributtedString = NSMutableAttributedString(string: agreeLabel.text!)
        
        attributtedString.addAttribute(.foregroundColor,
                                       value: Asset.mainColor.color,
                                       range: (agreeLabel.text! as NSString).range(of: "개인정보 처리방침"))
        
        attributtedString.addAttribute(.underlineStyle,
                                       value: NSUnderlineStyle.single.rawValue,
                                       range: (agreeLabel.text! as NSString).range(of: "개인정보 처리방침"))
        
        attributtedString.addAttribute(.underlineColor,
                                       value: Asset.mainColor.color,
                                       range: (agreeLabel.text! as NSString).range(of: "개인정보 처리방침"))
        
        agreeLabel.attributedText = attributtedString
        
    }
    
    func addSubView() {
        let textFieldArraay = [schoolNameTextField, schoolGradeTextField, schoolClassNumberTextField]
        let backViewArray = [textFieldBackView1, textFieldBackView2, textFieldBackView3]
        
        [signInNameLabbel, agreeLabel, agreeCheckBox, signInDoneButton].forEach {
            view.addSubview($0)
        }
        for count in 0..<3 {
            view.addSubview(backViewArray[count])
            backViewArray[count].addSubview(textFieldArraay[count])
        }
        
    }
    
    override func configureUI() {
        
        [schoolGradeTextField, schoolClassNumberTextField].forEach {
            $0.delegate = self
        }
        
        signInDoneButton.makeMyDesign(
            color: Asset.mainColor.color,
            title: "완료",
            titleColor: .white
        )
        
        makeTextField()
        makeAgreeText()
        addSubView()
        bind()
    }
    
    override func setupConstraints() {
        
        [textFieldBackView1, textFieldBackView2, textFieldBackView3].forEach { textField in
            textField.snp.makeConstraints {
                $0.height.equalTo(50)
                $0.leading.trailing.equalTo(view).inset(25)
            }
        }
        
        [schoolNameTextField, schoolGradeTextField, schoolClassNumberTextField].forEach { textField in
            textField.snp.makeConstraints {
                $0.leading.trailing.equalTo(textFieldBackView1).inset(10)
                $0.top.equalTo(15)
                $0.bottom.equalTo(-15)
            }
            
        }
        
        textFieldBackView1.snp.makeConstraints {
            $0.top.equalTo(signInNameLabbel.snp.bottom).offset(50)
        }
        textFieldBackView2.snp.makeConstraints {
            $0.top.equalTo(textFieldBackView1.snp.bottom).offset(25)
        }
        textFieldBackView3.snp.makeConstraints {
            $0.top.equalTo(textFieldBackView2.snp.bottom).offset(25)
        }

        signInNameLabbel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.height.equalTo(90)
            $0.leading.trailing.equalTo(view).inset(100)
        }
        
        signInDoneButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(15)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        agreeLabel.snp.makeConstraints {
            $0.top.equalTo(textFieldBackView3.snp.bottom).offset(10)
            $0.centerX.equalTo(view)
            $0.leading.equalTo(view).offset(50)
            $0.height.equalTo(20)
        }
        agreeCheckBox.snp.makeConstraints {
            $0.width.height.equalTo(15)
            $0.centerY.equalTo(agreeLabel)
            $0.leading.equalTo(view).offset(27)
        }
    }
    
}

extension SignInVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == schoolGradeTextField {
            schoolClassNumberTextField.becomeFirstResponder()
        }
        if textField == schoolClassNumberTextField {
            schoolClassNumberTextField.resignFirstResponder()
        }
        return true
    }
    
    func bind() {
        
        textFieldBackView1.rx.tapGesture()
            .when(.recognized)
            .bind {_ in
                self.presentPanModal(SearchSchoolVC())
            }.disposed(by: disposeBag)
        
        agreeLabel.rx.tapGesture()
            .when(.recognized)
            .bind {_ in
                self.navigationController?.pushViewController(ProcessingPolicyVC(), animated: true)
                self.agreeCheckBox.setOn(true, animated: true)
            }.disposed(by: disposeBag)
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        let extra = window!.safeAreaInsets.bottom
        
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { keyboardVisibleHeight in
                UIView.animate(withDuration: 0) {
                    self.signInDoneButton.snp.updateConstraints {
                        $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(keyboardVisibleHeight - extra + 15)
                    }
                }
                self.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }
    
}
