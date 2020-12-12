//
//  CustomButton.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 11/12/2020.
//

import UIKit

enum ButtonState: Int {
    case start = 1
    case end = 2
    case none = 0
}

class Button: UIButton {
    @IBInspectable var buttonIndex: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()

        layer()
    }

    func layer() {
        switch buttonIndex {
        case 1:
            layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor

        default:
            layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        }
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowOpacity = 2.0
        layer.shadowRadius = 0.0
    }
}
