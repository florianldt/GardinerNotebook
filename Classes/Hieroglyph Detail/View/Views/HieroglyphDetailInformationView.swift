//
//  HieroglyphDetailInformationView.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/9/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class HieroglyphDetailInformationView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        return label
    }()

    let informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()

    init() {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(informationLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
            ])
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            informationLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            informationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
            ])
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 10),
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String, information: String) {
        titleLabel.text = title
        informationLabel.text = information
    }

}
