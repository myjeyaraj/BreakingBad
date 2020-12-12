//
//  UIColor+Extenstion.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 11/12/2020.
//

import UIKit

enum AssetsColor: String {
    case backgroundColor1
    case primaryTextColor
    case secondaryTextColor
    case backgroundColor2
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        return UIColor(named: name.rawValue)!
    }

    static var darkBlue: UIColor {
        return UIColor(red: 15.0 / 255.0, green: 53.0 / 255.0, blue: 74.0 / 255.0, alpha: 1.0)
    }
    
    class var placeholderGrey: UIColor {
        return UIColor(red: 138.0 / 255.0, green: 138.0 / 255.0, blue: 139.0 / 255.0, alpha: 1.0)
    }
}
