//
//  AppDelegate.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/6/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UINavigationBar.appearance().tintColor = .black
        UITabBar.appearance().tintColor = UIColor.fromHex(Styles.Colors.gold)
        UIBarButtonItem.appearance().tintColor = .black

        FirebaseApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = GNTabBarController()
        window?.makeKeyAndVisible()
        return true
    }
}
