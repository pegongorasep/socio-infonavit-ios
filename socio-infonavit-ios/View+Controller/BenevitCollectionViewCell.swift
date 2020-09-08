//
//  BenevitaTableViewCell.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import UIKit

class BenevitCollectionViewCell: UICollectionViewCell {
    var item: BenevitModel? = nil

    // MARK: - Static
    static let reuseIdentifier = "BenevitCollectionViewCell"
    
   // MARK: - UI elements
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleOne: UILabel!
    @IBOutlet weak var subtitleTwo: UILabel!

    // MARK: - Helper
    
    func configure(with item: BenevitModel) {
        self.item = item

        if let urlString = item.ally?.miniLogoFullPath, !urlString.isEmpty, let url = URL(string: urlString) {
            backgroundImage.load(url: url)
        }
        
        backgroundColorView.backgroundColor = UIColor(hexString: item.primaryColor!)
        titleLabel.text = item.title
        
        if let territories = item.territories {
            if territories.count > 0 {
                subtitleOne.text = territories[0].name
            }
        }
        
        if let expirationDate = item.expirationDate {
            let startDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"

            if let endDate = formatter.date(from: expirationDate) {
                let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
                subtitleTwo.text = "Vence en: \(components.day!) días"
            }
        }
    }
}
