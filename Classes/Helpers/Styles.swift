//
//  Styles.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/10/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class Styles {

    enum Sizes {

        static let screenW: CGFloat = UIScreen.main.bounds.width
        static let screenH: CGFloat = UIScreen.main.bounds.height
        static let gutter: CGFloat = 18

        enum Cells {

            enum Hieroglyph {
                static let width: CGFloat = (Sizes.screenW - Sizes.gutter * 2 - 14) / 2
                static let height: CGFloat = width

                static let symbolFont: CGFloat = width * 0.4

            }
        }
    }
}
