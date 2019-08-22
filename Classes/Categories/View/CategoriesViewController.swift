//
//  CategoriesViewController.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/7/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices

class CategoriesViewController: UITableViewController {

    let interactor: CategoryListInteractor
    let disposeBag = DisposeBag()

    init(interactor: CategoryListInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
        interactor.fetchCategories()

        interactor
            .viewModel
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let infoBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_info"),
                                                    style: .plain, target: self,
                                                    action: #selector(onInfoBarButtonItem))
        navigationItem.rightBarButtonItem = infoBarButtonItem
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LoadingStateTableViewCell.self)
        tableView.register(ErrorStateTableViewCell.self)
        tableView.register(CategoryCell.self)
    }

    @objc
    private func onInfoBarButtonItem() {
        let message = "Thank you for the support!\n\(VersionManager().currentFormatted)"
        let infoAlertController = UIAlertController(title: "Gardiner's Memo",
                                                    message: message,
                                                    preferredStyle: .alert)
        let githubAction = UIAlertAction(title: "Contribute?", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.onGithubAction()
        }
        let reviewAction = UIAlertAction(title: "Write a Review", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.onWriteReview()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        infoAlertController.addAction(githubAction)
        infoAlertController.addAction(reviewAction)
        infoAlertController.addAction(cancelAction)
        present(infoAlertController, animated: true)
    }

    private func onGithubAction() {
        let safariController = SFSafariViewController(url: Consts.Urls.github)
        present(safariController, animated: true)
    }

    private func onWriteReview() {
        UIApplication.shared.open(Consts.Urls.rating, options: [:])
    }
}

extension CategoriesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.viewModel.value.numberOfItems
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let returnCell: UITableViewCell
        let cellViewModel = interactor.viewModel.value.viewModelType(at: indexPath)
        switch cellViewModel {
        case .loading:
            let cell = tableView.dequeue(LoadingStateTableViewCell.self, for: indexPath)
            cell.activityIndicator.startAnimating()
            returnCell = cell
        case .category(let viewModel):
            let cell = tableView.dequeue(CategoryCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        case .failure(let viewModel):
            let cell = tableView.dequeue(ErrorStateTableViewCell.self, for: indexPath)
            cell.configure(with: viewModel)
            returnCell = cell
        }
        return returnCell
    }
}

extension CategoriesViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? CategoryCell,
            let viewModel = cell.viewModel else { return }
        let categoryDetailInteractor = CategoryDetailInteractor(categoryViewModel: viewModel)
        let categroryDetailViewController = CategoryDetailViewController(interactor: categoryDetailInteractor)
        navigationController?.pushViewController(categroryDetailViewController, animated: true)
    }
}
