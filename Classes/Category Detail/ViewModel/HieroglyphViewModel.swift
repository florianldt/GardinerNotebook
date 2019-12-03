//
//  HieroglyphViewModel.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct HieroglyphViewModel {
    let id: String
    let unicode: String
    let description: String
    let transliteration: String
    let phonetic: String
    let note: String
}

extension HieroglyphViewModel {

    static func from(_ hieroglyphs: [Hieroglyph]) -> [HieroglyphViewModel] {
        return hieroglyphs
            .map { hieroglyph in
                var formattedUnicode: String {
                    guard let range = hieroglyph.unicode.range(of: "+")  else {
                        return "--"
                    }
                    return String(hieroglyph.unicode[range.upperBound...])
                }

                return HieroglyphViewModel(id: hieroglyph.id,
                                           unicode: formattedUnicode,
                                           description: hieroglyph.description.or("--"),
                                           transliteration: hieroglyph.transliteration.or("--"),
                                           phonetic: hieroglyph.phonetic.or("--"),
                                           note: hieroglyph.note.or("--"))
        }
    }

    static func from(_ categories: [Category], filteredBy term: String) -> [HieroglyphViewModel] {
        var hieroglyphs = [Hieroglyph]()
        for category in categories {
            hieroglyphs.append(contentsOf: category.hieroglyphs
                .filter {
                    return $0.id.lowercased().contains(term) || $0.description.lowercased().contains(term)
            })
        }
        return HieroglyphViewModel.from(hieroglyphs)
    }
}
