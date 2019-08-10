//
//  CategoryListViewModel.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/7/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct CategoryListViewModel {

    enum ViewModelType {
        case loading
        case category(CategoryViewModel)
        case failure(ErrorViewModel)
    }

    enum State {
        case initialized
        case loading
        case loaded([Category])
        case failed(Error)
    }

    let state: State
    let viewModels: [ViewModelType]

    init(with state: State) {
        self.state = state
        switch state {
        case .initialized:
            viewModels = []
        case .loading:
            viewModels = [
                .loading,
            ]
        case .loaded(let categories):
            let categoryViewModels = CategoryViewModel.from(categories)
            viewModels = categoryViewModels.map(ViewModelType.category)
        case .failed(let error):
            let errorViewModel = ErrorViewModel.from(error)
            viewModels = [
                .failure(errorViewModel),
            ]
        }
    }
}

extension CategoryListViewModel {

    var numberOfItems: Int {
        return viewModels.count
    }

    func viewModelType(at indexPath: IndexPath) -> ViewModelType {
        return viewModels[indexPath.row]
    }
}
