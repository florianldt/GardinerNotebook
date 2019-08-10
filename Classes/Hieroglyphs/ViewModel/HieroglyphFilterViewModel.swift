//
//  HieroglyphFilterViewModel.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/10/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct HieroglyphFilterViewModel {

    enum ViewModelType {
        case hieroglyph(HieroglyphViewModel)
    }

    let viewModels: [ViewModelType]
    let sectionTitle: String

    init(with categories: [Category], term: String) {
        let hieroglyphViewModels = HieroglyphViewModel.from(categories, filteredBy: term.lowercased())
        viewModels = hieroglyphViewModels.map(ViewModelType.hieroglyph)
        sectionTitle = String(format: "%d %@", viewModels.count, viewModels.count > 1 ? "matches" : "match")
    }
}

extension HieroglyphFilterViewModel {

    var numberOfItem: Int {
        return viewModels.count
    }

    func viewModelType(at indexPath: IndexPath) -> ViewModelType {
        return viewModels[indexPath.row]
    }
}
