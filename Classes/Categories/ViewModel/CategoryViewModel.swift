//
//  CategoryViewModel.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/7/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct CategoryViewModel {
    let id: String
    let name: String
    let hieroglyphs: [Hieroglyph]
}

extension CategoryViewModel {

    static func from(_ categories: [Category]) -> [CategoryViewModel] {
        return categories
            .map { CategoryViewModel(id: $0.id,
                                     name: $0.name,
                                     hieroglyphs: $0.hieroglyphs)
        }
    }
}
