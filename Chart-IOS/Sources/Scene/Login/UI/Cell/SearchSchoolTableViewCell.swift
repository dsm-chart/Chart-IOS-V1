//
//  SearchSchoolTableViewCell.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/20.
//

import UIKit

class SearchSchoolTableViewCell: BaseTableViewCell {
    
    private let cellView = UIView().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = Asset.viewColor.color
    }
    
    let schoolLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 18, weight: .medium)
    }
    let areaLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 16, weight: .medium)
        $0.textColor = Asset.labelColor.color
    }
    
    override func configureUI() {
        contentView.backgroundColor = Asset.backgroundColor.color
        contentView.addSubview(cellView)
        [schoolLabel, areaLabel].forEach { cellView.addSubview($0) }
        
        // dummy Data
        schoolLabel.text = "학교가 들어가요"
        areaLabel.text = "여기에는 학교의 주소가 들어가요"
    }
    
    override func setupConstraints() {
        cellView.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView).inset(7.5)
            $0.leading.trailing.equalTo(contentView).inset(25)
            $0.height.equalTo(100)
        }
        schoolLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(cellView).inset(30)
            $0.top.equalTo(20)
            $0.height.equalTo(26)
        }
        areaLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(cellView).inset(30)
            $0.top.equalTo(56)
            $0.height.equalTo(26)
        }
    }
    
}
