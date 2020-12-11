//
//  UIViewController+AlertView.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 11/12/2020.
//

import UIKit

extension UIViewController {
    static func showAlert(selfVC: UIViewController, title: String, message: String?) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "", style: UIAlertAction.Style.default, handler: nil))
        selfVC.present(alert, animated: true, completion: nil)
    }
}
