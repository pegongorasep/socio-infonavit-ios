//
//  BenevitLockedCollectionViewCell.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 08/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import UIKit

class BenevitLockedCollectionViewCell: UICollectionViewCell {
    var item: BenevitModel? = nil

    // MARK: - Static
    static let reuseIdentifier = "BenevitLockedCollectionViewCell"
    
    // MARK: - UI elements
     @IBOutlet weak var backgroundImage: UIImageView!

     // MARK: - Helper
     
     func configure(with item: BenevitModel) {
         self.item = item

         if let url = item.vectorFullPath, !url.isEmpty {
             backgroundImage.load(url: URL(string: url)!)
         }
     }
}
