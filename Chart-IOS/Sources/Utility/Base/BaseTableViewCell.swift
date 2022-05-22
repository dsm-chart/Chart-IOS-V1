//
//  BaseTableViewCell.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/17.
//

import UIKit
import SnapKit
import Then

class BaseTableViewCell: UITableViewCell {
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
        self.setupConstraints()
        self.initialize()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        
    }
    
    func configureUI() {
        
    }
    
    func setupConstraints() {
        
    }
    
}
