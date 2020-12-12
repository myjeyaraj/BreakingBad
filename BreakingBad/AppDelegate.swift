//
//  AppDelegate.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        setupAppearance()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func applicationDidBecomeActive(_: UIApplication) {
    }
}

extension AppDelegate {
    fileprivate func setupAppearance() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .appColor(.backgroundColor1)
        UINavigationBar.appearance().tintColor = .appColor(.primaryTextColor)
        UINavigationBar.appearance().shadowImage = UIImage()

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appColor(.primaryTextColor),
            NSAttributedString.Key.font: UIFont.semiBold20,
        ]

        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.appColor(.primaryTextColor),
            NSAttributedString.Key.font: UIFont.semiBold20,
        ], for: .normal)
    }
}
