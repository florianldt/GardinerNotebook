//
//  HieroglyphsViewController.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices

class HieroglyphsViewController: UICollectionViewController {

    let interactor: HieroglyphListInteractor
    let disposeBag = DisposeBag()

    var inSearchMode = false

    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Styles.Sizes.gutter
        layout.minimumInteritemSpacing = 10
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }()

    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search by id or description"
        return search
    }()

    init(interactor: HieroglyphListInteractor) {
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

        interactor
            .viewModel
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.collectionView.reloadData()
                }
            }).disposed(by: disposeBag)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        let infoBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_info"),
                                                style: .plain, target: self,
                                                action: #selector(onInfoBarButtonItem))
        navigationItem.rightBarButtonItem = infoBarButtonItem
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor.fromHex(Styles.Colors.backgroundLightGray)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeader(CategoryHeaderCell.self)
        collectionView.register(LoadingStateCollectionViewCell.self)
        collectionView.register(ErrorStateCollectionViewCell.self)
        collectionView.register(HieroglyphCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0,
                                                   left: 0,
                                                   bottom: Styles.Sizes.gutter,
                                                   right: 0)
    }

    @objc
    private func onInfoBarButtonItem() {
        let message = "Thank you for the support!\n\(VersionManager().currentFormatted)"
        let infoAlertController = UIAlertController(title: "Gardiner's Memo",
                                                    message: message,
                                                    preferredStyle: .alert)
        let githubAction = UIAlertAction(title: "Feedback / View source", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.onGithubAction()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        infoAlertController.addAction(githubAction)
        infoAlertController.addAction(cancelAction)
        present(infoAlertController, animated: true)
    }

    private func onGithubAction() {
        let safariController = SFSafariViewController(url: Consts.Urls.github)
        present(safariController, animated: true)
    }
}

extension HieroglyphsViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return interactor.viewModel.value.numberOfSections
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return interactor.viewModel.value.numberOfItems(for: section)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let returnCell: UICollectionViewCell
        let cellViewModel = interactor.viewModel.value.viewModelType(at: indexPath)
        switch cellViewModel {
        case .category(let viewModel):
            let cellViewModel = viewModel.viewModelType(at: indexPath)
            switch cellViewModel {
            case .hieroglyph(let viewModel):
                let cell = collectionView.dequeue(HieroglyphCell.self, for: indexPath)
                cell.configure(with: viewModel)
                returnCell = cell
            }
        case .filter(let viewModel):
            let cellViewModel = viewModel.viewModelType(at: indexPath)
            switch cellViewModel {
            case .hieroglyph(let viewModel):
                let cell = collectionView.dequeue(HieroglyphCell.self, for: indexPath)
                cell.configure(with: viewModel)
                returnCell = cell
            }
        case .loading:
            let cell = collectionView.dequeue(LoadingStateCollectionViewCell.self, for: indexPath)
            cell.activityIndicator.startAnimating()
            returnCell = cell
        case .failure(let viewModel):
            let cell = collectionView.dequeue(ErrorStateCollectionViewCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        }
        return returnCell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let cellViewModel = interactor.viewModel.value.viewModelType(at: indexPath)
            switch cellViewModel {
            case .category(let viewModel):
                let cell = collectionView.dequeueHeader(CategoryHeaderCell.self, for: indexPath)
                cell.configure(with: viewModel.sectionTitle)
                return cell
            case .filter(let viewModel):
                let cell = collectionView.dequeueHeader(CategoryHeaderCell.self, for: indexPath)
                cell.configure(with: viewModel.sectionTitle)
                return cell
            case .loading, .failure:
                preconditionFailure()
            }
        default:
            preconditionFailure()
        }
    }
}

extension HieroglyphsViewController {

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

extension HieroglyphsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let returnSize: CGSize
        let cellViewModel = interactor.viewModel.value.viewModelType(at: indexPath)
        switch cellViewModel {
        case .loading, .failure:
            returnSize = CGSize(width: Styles.Sizes.screenW,
                                height: 60)
        case .category, .filter:
            returnSize = CGSize(width: Styles.Sizes.Cells.Hieroglyph.width,
                                height: Styles.Sizes.Cells.Hieroglyph.height)
        }
        return returnSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: Styles.Sizes.gutter,
                            bottom: 0,
                            right: Styles.Sizes.gutter)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let returnSize: CGSize
        let constraintWidth: CGFloat = Styles.Sizes.screenW - Styles.Sizes.gutter * 2
        let cellViewModelType = interactor.viewModel.value.viewModelType(at: [section, 0])
        switch cellViewModelType {
        case .category(let viewModel):
            let titleHeight: CGFloat = viewModel.sectionTitle.heightWithConstrainedWidth(constraintWidth,
                                                                                    font: UIFont.systemFont(ofSize: 18,
                                                                                                            weight: .bold))
            returnSize = CGSize(width: Styles.Sizes.screenW, height: 14 + titleHeight + 14)
        case .filter(let viewModel):
            let titleHeight: CGFloat = viewModel.sectionTitle.heightWithConstrainedWidth(constraintWidth,
                                                                                         font: UIFont.systemFont(ofSize: 18,
                                                                                                                 weight: .bold))
            returnSize = CGSize(width: Styles.Sizes.screenW, height: 14 + titleHeight + 14)
        case .loading, .failure:
            returnSize = .zero
        }
        return returnSize
    }
}

extension HieroglyphsViewController {

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if inSearchMode {
            searchController.searchBar.resignFirstResponder()
        }
    }
}

extension HieroglyphsViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        interactor.filterHieroglyphs(by: text)
    }
}

extension HieroglyphsViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        inSearchMode = true
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        inSearchMode = false
    }
}
