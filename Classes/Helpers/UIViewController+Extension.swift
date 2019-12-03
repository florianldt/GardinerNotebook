//
//  UIViewController+Extension.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 12/3/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentBasicAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
