//
//  BenevitResponse.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import Foundation

struct WalletResponse: Codable {
    static let key = "BenevitResponseKey"

    let id: Int
    let displayText: String?
}
