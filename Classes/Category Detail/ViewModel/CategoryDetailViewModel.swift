//
//  CategoryDetailViewModel.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct CategoryDetailViewModel {

    enum ViewModelType {
        case hieroglyph(HieroglyphViewModel)
    }

    enum State {
        case initialized
        case loaded(CategoryViewModel)
    }

    let state: State
    let viewModels: [ViewModelType]

    init(with state: State) {
        self.state = state
        switch state {
        case .initialized:
            viewModels = []
        case .loaded(let categoryViewModel):
            let hieroglyphViewModels = HieroglyphViewModel.from(categoryViewModel.hieroglyphs)
            viewModels = hieroglyphViewModels.map(ViewModelType.hieroglyph)
        }
    }
}

extension CategoryDetailViewModel {

    var numberOfItems: Int {
        return viewModels.count
    }

    func viewModelType(at indexPath: IndexPath) -> ViewModelType {
        return viewModels[indexPath.row]
    }
}
