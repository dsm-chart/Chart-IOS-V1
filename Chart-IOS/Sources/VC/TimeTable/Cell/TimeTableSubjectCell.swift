//
// TimeTableSubjectCell.swift
//
// Created by 김대희 on 2022/05/18.
//

import UIKit
import SnapKit
import Then

class TimeTableSubjectCell: UICollectionViewCell {

    private let label = UILabel().then {
        $0.text = "과목명"
        $0.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.textAlignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(label)
        label.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
