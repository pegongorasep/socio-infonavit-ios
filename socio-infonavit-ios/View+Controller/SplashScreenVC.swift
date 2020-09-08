//
//  ViewController.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import UIKit
import SVProgressHUD

class SplashScreenVC: UIViewController {
    @IBOutlet weak var logoView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.show()
        logoView.alpha = 0.0

        // fade in
        UIView.animate(withDuration: 1.5, animations: {
            self.logoView.alpha = 1.0
        }) { (finished) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SVProgressHUD.dismiss()
                if AppDelegate.isLoggedIn {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BenevitsVC") as UIViewController
                    AppDelegate.standard.window?.rootViewController = UINavigationController(rootViewController: vc)
                } else {
                    AppDelegate.standard.window?.rootViewController = LoginVC()
                }
            }
        }
    }
}
