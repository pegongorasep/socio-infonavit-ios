//
//  BenevitsVC.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import UIKit
import SVProgressHUD
import KYDrawerController

class BenevitsVC: UIViewController {        
    var collection = [([BenevitModel]?, String?)]()
    var storedOffsets = [Int: CGFloat]()
    
    @IBOutlet weak var loadingBenevitsImage: UIImageView!
    @IBOutlet weak var walletsTableView: UITableView!
    private let walletsTableViewRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "hamburguer_menu"), style: .plain, target: self, action: #selector(openDrawer))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFill
        self.navigationItem.titleView = imageView
        
        
        walletsTableView.dataSource = self
        walletsTableView.delegate = self
        walletsTableView.separatorStyle = .none
        walletsTableViewRefreshControl.tintColor = .white
        walletsTableViewRefreshControl.addTarget(self, action: #selector (getBenevits), for: .valueChanged)
        walletsTableView.addSubview(walletsTableViewRefreshControl)
        
        getBenevits()
    }
    
    @objc func openDrawer() {
        if let drawerController = parent?.parent as? KYDrawerController {
            drawerController.setDrawerState(KYDrawerController.DrawerState.opened, animated: true)
        }
    }
    
    @objc func getBenevits() {
        SVProgressHUD.show()
        Benevit.getWallets() { response in
            
            switch response {
                
            // Got Succesful response
            case .success((let wallets)):
                
                Benevit.getBenevits() { response in
                    
                    SVProgressHUD.dismiss()
                    switch response {
                        
                    // Got Succesful response
                    case .success((let benevits)):
                        self.collection = [([BenevitModel]?, String?)]()

                        var dict: [Int : [BenevitModel]] = [:]
                        
                        for wallet in wallets {
                            dict[wallet.id] = []
                        }
                        
                        for (walletId, _) in dict {
                            
                            // Add to dictionary locked venebits
                            if let lockedBenevits = benevits.locked {
                                for benevit in lockedBenevits {
                                    if walletId == benevit.wallet?.id {
                                        var tempBenevit = benevit
                                        tempBenevit.isLocked = true
                                        dict[walletId]!.append(tempBenevit)
                                    }
                                }
                            }
                            
                            // Add to dictionary unlocked venebits
                            if let unlockedBenevits = benevits.unlocked {
                                for benevit in unlockedBenevits {
                                    if walletId == benevit.wallet?.id {
                                        var tempBenevit = benevit
                                        tempBenevit.isLocked = false
                                        dict[walletId]!.append(tempBenevit)
                                    }
                                }
                            }
                        }
                        
                        // set final data for table
                        for (_, walletArray) in dict {
                            if walletArray.count > 0 {
                                self.collection.append((nil, walletArray[0].wallet?.name))
                                self.collection.append((walletArray, nil))
                            }
                        }
                        
                        // refresh ui
                        self.walletsTableView.reloadData()
                        self.loadingBenevitsImage.isHidden = true
                        SVProgressHUD.dismiss()
                        
                        
                    // Show error
                    case .failure( _):
                        SVProgressHUD.dismiss()
                        let alert: UIAlertController
                        alert = UIAlertController(title: "Error", message: "Usuaro o password incorrecto", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                        self.present(alert, animated: true)
                    }
                }
                
            // Show error
            case .failure( _):
                SVProgressHUD.dismiss()
                let alert: UIAlertController
                alert = UIAlertController(title: "Error", message: "Usuaro o password incorrecto", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
}



// MARK: - UITableViewDataSource,UITableViewDelegate
extension BenevitsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if collection[indexPath.row].0 != nil {
            return CGFloat(300.0)
            
        } else {
            return CGFloat(50.0)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if collection[indexPath.row].0 != nil {
            return tableView.dequeueReusableCell(withIdentifier: "WalletListTableViewCell", for: indexPath)
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalletListTableViewHeaderCell", for: indexPath) as! WalletListTableViewHeaderCell
            cell.configure(with: collection[indexPath.row].1!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? WalletListTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? WalletListTableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}



// MARK: - UICollectionViewDelegate
extension BenevitsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(280.0)
        let width = CGFloat(250.0)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}




// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension BenevitsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection[collectionView.tag].0!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = collection[collectionView.tag].0![indexPath.item]
        
        // Configure cell
        let cell: UICollectionViewCell
        if data.isLocked! {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: BenevitLockedCollectionViewCell.reuseIdentifier, for: indexPath)
           (cell as! BenevitLockedCollectionViewCell).configure(with: data)

        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: BenevitCollectionViewCell.reuseIdentifier, for: indexPath)
            (cell as! BenevitCollectionViewCell).configure(with: data)
        }
        
        return cell
    }
}
