//
//  ErrorViewModel.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/7/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct ErrorViewModel {
    let description: String
}

extension ErrorViewModel {

    static func from(_ error: Error) -> ErrorViewModel {
        return ErrorViewModel(description: error.localizedDescription)
    }
}
