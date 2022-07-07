//
//  SettingListCell.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/23.
//

import UIKit

class SettingListCell: BaseTableViewCell {

    private let backView = UIView().then {
        $0.backgroundColor = Asset.viewColor.color
        $0.layer.cornerRadius = 20
    }

    let titleLabel = UILabel().then {
        $0.textColor = Asset.labelColor.color
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }

    override func configureUI() {

        contentView.backgroundColor = Asset.backgroundColor.color
        contentView.addSubview(backView)

        [titleLabel].forEach {
            backView.addSubview($0)
        }

    }

    override func setupConstraints() {

        backView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(35)
            $0.height.equalTo(60)
            $0.top.bottom.equalTo(contentView).inset(7.5)
        }

        titleLabel.snp.makeConstraints {
            $0.left.right.equalTo(backView).inset(15)
            $0.top.bottom.equalTo(backView).inset(15)
        }
    }
}
