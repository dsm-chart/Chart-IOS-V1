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
            self.requestCode()
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
    
    // 추후 리액터로 넣어줄 값들
    func requestCode() {
        let urlString = "\(Base.githubURL)/login/oauth/authorize?client_id=\(Base.githubClientId)&scope=\(Base.githubScope)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
