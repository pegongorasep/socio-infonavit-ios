//
//  UIButton.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import UIKit

extension UIButton {
    func setFinishButton(validation: () ->Bool) {
        // enable
        if validation() {
            self.backgroundColor = UIColor(hexString: "EC5056")
            self.setTitleColor(.white, for: .normal)
            self.isUserInteractionEnabled = true
            
        //disable
        } else {
            self.backgroundColor = UIColor(hexString: "ACACAC")
            self.setTitleColor(.white, for: .normal)
            self.isUserInteractionEnabled = false
        }
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2
    }
}
