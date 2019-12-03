//
//  UIImage+Extension.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 12/3/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageWithView(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
