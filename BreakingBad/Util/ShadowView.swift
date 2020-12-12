//
//  ShadowView.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 11/12/2020.
//

import UIKit

class ShadowView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: Constants.View.cornerRadius).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = Constants.View.shadowOffset
        layer.shadowOpacity = Constants.View.shadowOpacity
        layer.shadowRadius = Constants.View.shadowRadius
        layer.shouldRasterize = true
    }
}
