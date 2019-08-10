//
//  CategoriesInteractor.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/7/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CategoryListInteractor {

    let viewModel: BehaviorRelay<CategoryListViewModel>

    init() {
        viewModel = BehaviorRelay(value: .init(with: .initialized))
    }

    func fetchCategories() {
        viewModel.accept(.init(with: .loading))
        Json().from("gardiner_list", type: [Category].self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let categories):
                strongSelf.viewModel.accept(.init(with: .loaded(categories)))
            case .failure(let error):
                strongSelf.viewModel.accept(.init(with: .failed(error)))
            }
        }
    }
}
