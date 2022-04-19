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
    
    private let schoolNameTextField = UITextField()
    private let schoolGradeTextField = UITextField()
    private let schoolClassNumberTextField = UITextField()
    
    private let textFieldBackView1 = UIView()
    private let textFieldBackView2 = UIView()
    private let textFieldBackView3 = UIView()
    
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
