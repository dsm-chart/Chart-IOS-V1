//
//  SettingListCell.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/23.
//

import UIKit

class SettingListCell: BaseTableViewCell {
    let titleLabel = UILabel().then {
        $0.textColor = Asset.labelColor.color
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    private let customRightImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right.circle")
        $0.tintColor = Asset.mainColor.color
    }
    
    override func configureUI() {
        contentView.backgroundColor = Asset.backgroundColor.color
        [titleLabel, customRightImage].forEach {
            contentView.addSubview($0)
        }
        
    }
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.height.left.equalTo(20)
            $0.top.bottom.equalTo(contentView).inset(15)
        }
        customRightImage.snp.makeConstraints {
            $0.width.height.equalTo(25)
            $0.right.equalTo(-37)
            $0.centerY.equalTo(contentView)
        }
    }
    
}
