//
//  UIColor+Extension.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/10/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

extension UIColor {

    enum Names: String {
        case backgroundLightGray
        case tint
        case errorLabel
        case gold

        var color: UIColor {
            guard let color = UIColor(named: self.rawValue) else {
                preconditionFailure("\(self.rawValue) color not implemented!")
            }
            return color
        }
    }
}
