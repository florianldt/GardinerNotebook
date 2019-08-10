//
//  Version+Helper.swift
//  GardinerNotebook
//
//  Created by Florian LUDOT on 8/10/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct VersionManager {

    var releaseVersionNumber: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }

    var currentFormatted: String {
        return String(format: "Version %@ (%@)",
                      releaseVersionNumber ?? "",
                      buildVersionNumber ?? "")
    }

}
