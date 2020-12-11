//
//  UIView+Extension.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 11/12/2020.
//

import UIKit

extension UIView {
    func addShadow() {
        let shadowPath = UIBezierPath(rect: bounds).cgPath

        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.2
        layer.shadowPath = shadowPath
    }
}
