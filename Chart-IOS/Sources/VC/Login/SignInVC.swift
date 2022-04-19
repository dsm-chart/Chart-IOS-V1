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
        
    }
        
    override func configureUI() {
        signInDoneButton.makeMyDesign(color: Asset.mainColor.color, title: "완료", titleColor: .white)
        addSubView()
    }
    
}
