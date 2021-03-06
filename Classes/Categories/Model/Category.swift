//
//  Category.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/7/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: String
    let name: String
    let hieroglyphs: [Hieroglyph]
}
