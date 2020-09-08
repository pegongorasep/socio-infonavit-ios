//
//  WalletListTableViewCell2.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import UIKit

class WalletListTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!

}

extension WalletListTableViewCell {

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {

        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
