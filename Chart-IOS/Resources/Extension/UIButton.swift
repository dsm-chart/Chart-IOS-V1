//
//  UIButton.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/04/19.
//

import UIKit

extension UIButton {
    func makeMyDesign(
        color : UIColor,
        title : String,
        titleColor : UIColor,
        image : UIImage? = nil) {
            self.setTitleColor(titleColor, for: .normal)
            self.setTitle(title, for: .normal)
            self.setImage(image, for: .normal)
            self.backgroundColor = color
            self.layer.cornerRadius = 10
        }
}
