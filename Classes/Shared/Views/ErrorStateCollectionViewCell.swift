//
//  ErrorStateCollectionViewCell.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/10/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class ErrorStateCollectionViewCell: UICollectionViewCell {

    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.Names.errorLabel.color
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            errorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Styles.Sizes.gutter),
            errorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Styles.Sizes.gutter),
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: ErrorViewModel) {
        errorLabel.text = viewModel.description
    }
}
