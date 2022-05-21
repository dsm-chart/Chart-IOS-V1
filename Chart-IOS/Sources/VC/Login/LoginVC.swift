//
//  LoginVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/19.
//

import UIKit

class LoginVC: BaseViewController {
    
    private let welcomeImageView = UIImageView().then {
        $0.image = Asset.loginLogo.image
        $0.contentMode = .scaleAspectFit
    }
    
    private let loginGithubButton = UIButton()
    
    override func configureUI() {
        loginGithubButton.makeMyDesign(color: Asset.mainColor.color, title: " Github 로그인하기", titleColor: .white, image: Asset.github.image)
        [welcomeImageView, loginGithubButton].forEach {
            view.addSubview($0)
        }
        
        loginGithubButton.rx.tap.bind {
            self.navigationController?.pushViewController(SignInVC(), animated: true)
        }.disposed(by: disposeBag)
        
    }
    
    override func setupConstraints() {
        
        welcomeImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.height.equalTo(90)
            $0.leading.trailing.equalTo(view).inset(100)
        }
        
        loginGithubButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(15)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
        }
        
    }
    
}
