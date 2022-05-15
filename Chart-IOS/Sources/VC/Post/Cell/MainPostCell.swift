//
//  MainPostCell.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/12.
//

import UIKit

class MainPostCell: BaseTableViewCell {
    
    private let backView = UIView().then {
        $0.backgroundColor = Asset.viewColor.color
        $0.layer.cornerRadius = 20
    }
    
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    let bodylabel = UILabel()
    
    func createLabel() {
        
        [titleLabel, bodylabel].forEach {
            $0.textColor = Asset.labelColor.color
        }
        
        nameLabel.textColor = Asset.mainColor.color
        nameLabel.textAlignment = .right
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        bodylabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        titleLabel.text = "제목이 들어가요"
        nameLabel.text = "이름이 들어가요"
        bodylabel.text = "여기에는 본문이 한줄 들어가요"
    }
    
    override func configureUI() {
        createLabel()
        contentView.addSubview(backView)
        contentView.backgroundColor = Asset.backgroundColor.color
        [titleLabel, nameLabel, bodylabel].forEach {
            backView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        backView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(35)
            $0.height.equalTo(100)
            $0.top.bottom.equalTo(contentView).inset(7.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalTo(20)
            $0.height.equalTo(26)
        }
        
        nameLabel.snp.makeConstraints {
            $0.trailing.equalTo(-20)
            $0.top.equalTo(20)
            $0.height.equalTo(26)
        }
        
        bodylabel.snp.makeConstraints {
            $0.top.equalTo(56)
            $0.leading.trailing.equalTo(backView).inset(20)
            $0.height.equalTo(26)
        }
        
    }
    
}
