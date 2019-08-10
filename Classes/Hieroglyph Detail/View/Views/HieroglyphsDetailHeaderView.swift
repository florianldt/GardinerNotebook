//
//  HieroglyphsDetailHeaderView.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class HieroglyphsDetailHeaderView: UIView {

    let symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width * 0.4, weight: .medium)
        return label
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(symbolLabel)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.6),
            ])
        NSLayoutConstraint.activate([
            symbolLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            symbolLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: HieroglyphViewModel) {
        if
            let unicode = viewModel.unicode,
            let charAsInt = Int(unicode, radix: 16),
            let uScalar = UnicodeScalar(charAsInt) {
            symbolLabel.text = String(uScalar)
        } else {
            symbolLabel.text = "Incorrect unicode character"
        }
    }
}
