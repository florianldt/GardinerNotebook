//
//  ieroglyphListInteractor.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HieroglyphListInteractor {

    let viewModel: BehaviorRelay<HieroglyphListViewModel>

    init() {
        viewModel = BehaviorRelay(value: .init(with: .initialized))
    }
}

extension HieroglyphListInteractor {

    func fetchHieroglyphs() {
        viewModel.accept(.init(with: .loading))
        Json().from("gardiner_list",
                    type: [Category].self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let categories):
                strongSelf.viewModel.accept(.init(with: .loaded(categories)))
            case .failure(let errorDescription):
                strongSelf.viewModel.accept(.init(with: .failed(errorDescription)))
            }
        }
    }

    func filterHieroglyphs(by term: String) {
        switch viewModel.value.state {
        case .loaded(let categories),
             .filtered(_, let categories):
            guard !term.isEmpty else {
                if case .loaded = viewModel.value.state {
                    return
                } else {
                    fetchHieroglyphs()
                    return
                }
            }
            viewModel.accept(.init(with: .filtered(term, categories)))
        case .initialized,
             .loading,
             .failed:
            return
        }

    }
}
