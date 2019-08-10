//
//  UICollectionViewController+Extension.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/8/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type,
                                           reuseIdentifier: String? = nil) {
        self.register(T.self,
                      forCellWithReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }

    func dequeue<T: UICollectionViewCell>(_: T.Type,
                                          for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                             for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }

        return cell
    }

    func registerHeader<T: UICollectionReusableView>(_: T.Type,
                                                     reuseIdentifier: String? = nil) {
        self.register(T.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }

    func dequeueHeader<T: UICollectionReusableView>(_: T.Type,
                                                    for indexPath: IndexPath) -> T {
        guard
            let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                          withReuseIdentifier: String(describing: T.self),
                                                          for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        return header
    }

    func registerFooter<T: UICollectionReusableView>(_: T.Type,
                                                     reuseIdentifier: String? = nil) {
        self.register(T.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }

    func dequeueFooter<T: UICollectionReusableView>(_: T.Type,
                                                    for indexPath: IndexPath) -> T {
        guard let footer = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                            withReuseIdentifier: String(describing: T.self),
                                                            for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        return footer
    }
}
