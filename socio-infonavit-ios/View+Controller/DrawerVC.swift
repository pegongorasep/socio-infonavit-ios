//
//  DrawerVC.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 08/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

//
//  ViewController.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import UIKit
import KYDrawerController

class DrawerVC: UIViewController {
    @IBAction func benevits(_ sender: Any) {
        if let drawerController = parent as? KYDrawerController {
            drawerController.setDrawerState(KYDrawerController.DrawerState.closed, animated: true)
        }
    }
    @IBAction func logOut(_ sender: Any) {
        AppDelegate.logOut()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
