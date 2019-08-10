//
//  GNTabBarController.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class GNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    private func setupViewControllers() {

        let categoryListInteractor = CategoryListInteractor()
        let categoriesViewController = CategoriesViewController(interactor: categoryListInteractor)

        let hieroglyphListInteractor = HieroglyphListInteractor()
        let hieroglyphsViewController = HieroglyphsViewController(interactor: hieroglyphListInteractor)

        setupTabBarItem(viewController: categoriesViewController,
                        image: "tabBar_categories",
                        title: "Categories")
        setupTabBarItem(viewController: hieroglyphsViewController,
                        image: "tabBar_hieroglyphs",
                        title: "Hieroglyphs")

        let categoriesNavigationController = UINavigationController(rootViewController: categoriesViewController)
        let hieroglyphsNavigationController = UINavigationController(rootViewController: hieroglyphsViewController)

        viewControllers = [categoriesNavigationController,
                           hieroglyphsNavigationController,
        ]

    }

    private func setupTabBarItem(viewController: UIViewController, image: String, title: String) {
        viewController.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        viewController.title = title
    }
}
