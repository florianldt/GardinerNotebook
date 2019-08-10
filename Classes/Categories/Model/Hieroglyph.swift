//
//  Hieroglyph.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct Hieroglyph: Codable {
    let id: String
    let unicode: String
    let description: String
    let transliteration: String
    let phonetic: String
    let note: String
}
