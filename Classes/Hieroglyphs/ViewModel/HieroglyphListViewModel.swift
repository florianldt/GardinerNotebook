//
//  HieroglyphListViewModel.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct HieroglyphListViewModel {

    enum ViewModelType {
        case loading
        case category(HieroglyphSectionViewModel)
        case filter(HieroglyphFilterViewModel)
        case failure(ErrorViewModel)
    }

    enum State {
        case initialized
        case loading
        case loaded([Category])
        case filtered(String, [Category])
        case failed(String?)
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
            let sectionViewModels = categories.map(HieroglyphSectionViewModel.init)
            viewModels = sectionViewModels.map(ViewModelType.category)
        case .filtered(let term, let categories):
            let filterViewModel = HieroglyphFilterViewModel(with: categories, term: term)
            viewModels = [
                .filter(filterViewModel),
            ]
        case .failed(let error):
            let errorViewModel = ErrorViewModel.from(error)
            viewModels = [
                .failure(errorViewModel),
            ]
        }
    }
}

extension HieroglyphListViewModel {

    var numberOfSections: Int {
        let returnNumber: Int
        switch state {
        case .initialized, .loading, .loaded, .failed:
            returnNumber = viewModels.count
        case .filtered:
            returnNumber = 1
        }
        return returnNumber
    }

    func numberOfItems(for section: Int) -> Int {
        let returnNumber: Int
        let cellViewModel = viewModelType(at: [section, 0])
        switch cellViewModel {
        case .loading:
            returnNumber = 1
        case .category(let viewModel):
            returnNumber = viewModel.numberOfItem
        case .filter(let viewModel):
            returnNumber = viewModel.numberOfItem
        case .failure:
            returnNumber = 1
        }
        return returnNumber
    }

    func viewModelType(at indexPath: IndexPath) -> ViewModelType {
        return viewModels[indexPath.section]
    }
}
