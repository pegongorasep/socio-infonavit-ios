//
//  BenevitResponse.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import Foundation

struct BenevitResponse: Codable {
    static let key = "BenevitResponseKey"

    let locked: [BenevitModel]?
    let unlocked: [BenevitModel]?
}

struct BenevitModel: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let title: String?
    let instructions: String?
    let expirationDate: String?
    let primaryColor: String?
    let wallet: WalletModel?
    let territories: [Territories]?
    let ally: AllyModel?

    let vectorFullPath: String?
    
    var isLocked: Bool?
}

struct WalletModel: Codable {
    let id: Int?
    let name: String?
}

struct AllyModel: Codable {
    let id: Int?
    let miniLogoFullPath: String?
}

struct Territories: Codable {
    let id: Int?
    let name: String?
}
