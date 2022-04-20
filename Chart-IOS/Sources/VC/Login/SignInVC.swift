//
//  SignInVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/19.
//

import Foundation
import UIKit

class SignInVC: BaseViewController {
    
    private let signInNameLabbel = UILabel()
    private let signInDoneButton = UIButton()
    
    private let schoolNameTextField = UILabel().then {
        $0.text = "학교를 검색하세요"
        $0.font = .roundedFont(ofSize: 18, weight: .medium)
        $0.textColor = .separator
    }
    
    private let schoolGradeTextField = UITextField()
    private let schoolClassNumberTextField = UITextField()
    
    private let textFieldBackView1 = UIView()
    private let textFieldBackView2 = UIView()
    private let textFieldBackView3 = UIView()
    
    func makeTextField() {
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.separator,
            NSAttributedString.Key.font : UIFont.roundedFont(ofSize: 18, weight: .medium)
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
        
        schoolGradeTextField.attributedPlaceholder = NSAttributedString(string: "학년을 입력하세요 (ex : 1", attributes:attributes)
        schoolClassNumberTextField.attributedPlaceholder = NSAttributedString(string: "학변을 입력하세요 (ex : 01", attributes:attributes)
        
    }
    
    func addSubView() {
        let textFieldArraay = [schoolNameTextField, schoolGradeTextField, schoolClassNumberTextField]
        let backViewArray = [textFieldBackView1, textFieldBackView2, textFieldBackView3]
        
        [signInNameLabbel, signInDoneButton].forEach {
            view.addSubview($0)
        }
        for count in 0..<3 {
            view.addSubview(backViewArray[count])
            backViewArray[count].addSubview(textFieldArraay[count])
        }
        
    }
    
    override func configureUI() {
        signInDoneButton.makeMyDesign(color: Asset.mainColor.color, title: "완료", titleColor: .white)
        addSubView()
    }
    
}
