//
//  WalletListTableViewCell.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import UIKit

class WalletListTableViewHeaderCell: UITableViewCell {

    // MARK: - UI elements
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
