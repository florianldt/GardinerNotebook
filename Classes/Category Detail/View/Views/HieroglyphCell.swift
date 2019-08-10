//
//  HieroglyphCell.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class HieroglyphCell: UICollectionViewCell {

    var viewModel: HieroglyphViewModel?

    let hieroglyphSymbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Styles.Sizes.Cells.Hieroglyph.symbolFont, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    let hieroglyphIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 7
        contentView.addSubview(hieroglyphSymbolLabel)
        contentView.addSubview(hieroglyphIdLabel)

        NSLayoutConstraint.activate([
            hieroglyphSymbolLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            hieroglyphSymbolLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            hieroglyphSymbolLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            ])
        NSLayoutConstraint.activate([
            hieroglyphIdLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            hieroglyphIdLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            hieroglyphIdLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: HieroglyphViewModel) {
        self.viewModel = viewModel
        if
            let unicode = viewModel.unicode,
            let charAsInt = Int(unicode, radix: 16),
            let uScalar = UnicodeScalar(charAsInt) {
            hieroglyphSymbolLabel.text = String(uScalar)
        } else {
            hieroglyphSymbolLabel.text = "Incorrect unicode character"
        }
        hieroglyphIdLabel.text = viewModel.id
    }
}
