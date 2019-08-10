//
//  CategoryHeaderCell.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class CategoryHeaderCell: UICollectionViewCell {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.fromHex(Styles.Colors.backgroundLightGray)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Styles.Sizes.gutter),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Styles.Sizes.gutter),
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var layer: CALayer {
        let layer = super.layer
        layer.zPosition = 0 // make the header appear below the collection view scroll bar
        return layer
    }

    func configure(with text: String) {
        nameLabel.text = text
    }
}
