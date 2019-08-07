//
//  AppDelegate.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/6/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let categoriesViewController = CategoriesViewController()
        window?.rootViewController = UINavigationController(rootViewController: categoriesViewController)
        window?.makeKeyAndVisible()
        return true
    }
}
