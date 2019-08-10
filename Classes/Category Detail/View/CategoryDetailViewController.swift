//
//  CategoryDetailViewController.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UICollectionViewController {

    let interactor: CategoryDetailInteractor

    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Styles.Sizes.gutter
        layout.minimumInteritemSpacing = 10
        return layout
    }()

    init(interactor: CategoryDetailInteractor) {
        self.interactor = interactor
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        interactor.fetchHieroglyphs()
    }

    private func setupNavigationBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        title = interactor.title
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor.fromHex(Styles.Colors.backgroundLightGray)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HieroglyphCell.self)
        collectionView.contentInset = UIEdgeInsets(top: Styles.Sizes.gutter,
                                                   left: 0,
                                                   bottom: Styles.Sizes.gutter,
                                                   right: 0)
    }
}

extension CategoryDetailViewController {

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return interactor.viewModel.value.numberOfItems
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let returnCell: UICollectionViewCell
        let cellViewModel = interactor.viewModel.value.viewModelType(at: indexPath)
        switch cellViewModel {
        case .hieroglyph(let viewModel):
            let cell = collectionView.dequeue(HieroglyphCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        }
        return returnCell
    }
}

extension CategoryDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Styles.Sizes.Cells.Hieroglyph.width,
                      height: Styles.Sizes.Cells.Hieroglyph.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: Styles.Sizes.gutter,
                            bottom: 0,
                            right: Styles.Sizes.gutter)
    }
}

extension CategoryDetailViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? HieroglyphCell,
            let viewModel = cell.viewModel
            else { return }
        let hieroglyphDetailInteractor = HieroglyphDetailInteractor(hieroglyphViewModel: viewModel)
        let hieroglyphDetailViewController = HieroglyphDetailViewController(interactor: hieroglyphDetailInteractor)
        present(UINavigationController(rootViewController: hieroglyphDetailViewController), animated: true)
    }
}
