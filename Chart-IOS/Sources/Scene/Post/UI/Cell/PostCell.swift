//
//  MainPostCell.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/12.
//

import UIKit

class PostCell: BaseTableViewCell {
    
    private let backView = UIView().then {
        $0.backgroundColor = Asset.viewColor.color
        $0.layer.cornerRadius = 20
    }
    
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    let contentLabel = UILabel()

    func createLabel() {
        
        [firstLabel, contentLabel].forEach {
            $0.textColor = Asset.labelColor.color
        }
        
        secondLabel.textColor = Asset.mainColor.color
        secondLabel.textAlignment = .right
        
        firstLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        secondLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        contentLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
    }
    
    override func configureUI() {
        createLabel()
        contentView.addSubview(backView)
        contentView.backgroundColor = Asset.backgroundColor.color
        [firstLabel, secondLabel, contentLabel].forEach {
            backView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        backView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(35)
            $0.height.equalTo(100)
            $0.top.bottom.equalTo(contentView).inset(7.5)
        }
        
        firstLabel.snp.makeConstraints {
            $0.leading.top.equalTo(20)
            $0.trailing.equalTo(secondLabel.snp.leading).offset(-10)
            $0.height.equalTo(26)
        }
        
        secondLabel.snp.makeConstraints {
            $0.trailing.equalTo(-20)
            $0.top.equalTo(20)
            $0.height.equalTo(26)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(56)
            $0.leading.trailing.equalTo(backView).inset(20)
            $0.height.equalTo(26)
        }
        
    }
    
}
