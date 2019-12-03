//
//  String+Extension.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/10/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

extension String {

    func or(_ substitute: String) -> String {
        return self.isEmpty ? substitute : self
    }

    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.height
    }

    var toUnicodeCharacter: String {
        guard
            let charAsInt = Int(self, radix: 16),
            let uScalar = UnicodeScalar(charAsInt)
            else {
            return "--"
        }
        return String(uScalar)
    }
}
