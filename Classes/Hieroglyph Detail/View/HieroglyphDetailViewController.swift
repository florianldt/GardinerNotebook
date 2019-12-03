//
//  HieroglyphDetailViewController.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit
import AloeStackView

class HieroglyphDetailViewController: AloeStackViewController {

    let interactor: HieroglyphDetailInteractor
    var hieroglyphsDetailHeaderView: HieroglyphsDetailHeaderView!

    init(interactor: HieroglyphDetailInteractor) {
        self.interactor = interactor
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var backgroundColor: UIColor {
            if #available(iOS 13.0, *) {
                return .systemBackground
            } else {
                return .white
            }
        }
        stackView.backgroundColor = backgroundColor
        setupNavigationBar()
        setupStackView()
    }

    private func setupNavigationBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        title = interactor.hieroglyphViewModel.id
        var dynamicColor: UIColor {
            if #available(iOS 13.0, *) {
                return .systemBackground
            } else {
                return .white
            }
        }
        navigationController?.navigationBar.backgroundColor = dynamicColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        let dismissBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop,
                                                   target: self,
                                                   action: #selector(onDismissBarButtonitem))
        let copyBarButtonItem = UIBarButtonItem(title: "Export",
                                                style: .plain,
                                                target: self,
                                                action: #selector(onExportBarButtonItem))
        navigationItem.leftBarButtonItem = dismissBarButtonItem
        navigationItem.rightBarButtonItem = copyBarButtonItem
    }

    @objc
    private func onDismissBarButtonitem() {
        dismiss(animated: true)
    }

    @objc
    private func onExportBarButtonItem() {
        let alertController = UIAlertController(title: nil,
                                                message: "Choose an export option",
                                                preferredStyle: .actionSheet)
        let characterAction = UIAlertAction(title: "Copy as character", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.onCharacterAction()
        }
        let imageAction = UIAlertAction(title: "Save as image", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.onImageAction()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(characterAction)
        alertController.addAction(imageAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    private func onCharacterAction() {
        UIPasteboard.general.string = interactor.hieroglyphViewModel.unicode.toUnicodeCharacter
    }

    private func onImageAction() {
        guard let image = UIImage.imageWithView(view: hieroglyphsDetailHeaderView) else {
            presentBasicAlert(title: "The hieroglyph cannot be exported!", message: nil)
            return
        }
        UIImageWriteToSavedPhotosAlbum(image,
                                       self,
                                       #selector(image(_:didFinishSavingWithError:contextInfo:)),
                                       nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        guard error != nil else {
            presentBasicAlert(title: "Image saved!",
                              message: nil)
            return
        }
        presentBasicAlert(title: "Error while saving the image. Be sure you have authorized the app to save images!",
                          message: nil)
    }

    private func setupStackView() {
        stackView.alwaysBounceVertical = true
        setupHeaderView()
        setupDescriptionView()
        setupTransliterationView()
        setupPhoneticView()
        setupNoteView()
    }

    private func setupHeaderView() {
        hieroglyphsDetailHeaderView = HieroglyphsDetailHeaderView()
        hieroglyphsDetailHeaderView.configure(with: interactor.hieroglyphViewModel)
        stackView.addRow(hieroglyphsDetailHeaderView)
    }

    private func setupDescriptionView() {
        let view = HieroglyphDetailInformationView()
        view.configure(with: "Description:", information: interactor.hieroglyphViewModel.description)
        stackView.addRow(view)
    }

    private func setupTransliterationView() {
        let view = HieroglyphDetailInformationView()
        view.configure(with: "Transliteration:", information: interactor.hieroglyphViewModel.transliteration)
        stackView.addRow(view)
    }

    private func setupPhoneticView() {
        let view = HieroglyphDetailInformationView()
        view.configure(with: "Phonetic:", information: interactor.hieroglyphViewModel.phonetic)
        stackView.addRow(view)
    }

    private func setupNoteView() {
        let view = HieroglyphDetailInformationView()
        view.configure(with: "Note:", information: interactor.hieroglyphViewModel.note)
        stackView.addRow(view)
        stackView.hideSeparator(forRow: view)
    }
}
