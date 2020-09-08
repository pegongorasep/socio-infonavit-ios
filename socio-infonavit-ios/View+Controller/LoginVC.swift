//
//  LoginMenuVC.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    @IBAction func signInButton(_ sender: Any) {
        
        SVProgressHUD.show()
        User.login(with: email!, and: password!) { response in
            SVProgressHUD.dismiss()

            switch response {
                
            // Got Succesful response
            case .success((let userResponse)):
                
                // login
                AppDelegate.login(with: userResponse)
                
                // go to main vc
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BenevitsVC") as UIViewController
                AppDelegate.standard.window?.rootViewController = UINavigationController(rootViewController: vc)

            // Show error
            case .failure( _):
                let alert: UIAlertController
                alert = UIAlertController(title: "Error", message: "Usuaro o password incorrecto", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
    
    private var email: String? {
        didSet {
            signInButton.setFinishButton {
                if let email = email, !email.isEmpty, let password = password, !password.isEmpty { return true } else { return false }
            }
        }
    }
    
    private var password: String? {
        didSet {
            signInButton.setFinishButton {
                if let email = email, !email.isEmpty, let password = password, !password.isEmpty { return true } else { return false }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        signInButton.setFinishButton {
            if let email = email, !email.isEmpty, let password = password, !password.isEmpty { return true } else { return false }
        }
            
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @objc private func emailTextFieldDidChange()  {
        email = emailTextField.text
    }
    @objc private func passwordTextFieldDidChange()  {
        password = passwordTextField.text
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
           nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()

            if nextTag == 3 {
                self.signInButton.sendActions(for: .touchUpInside)
            }
        }

        return true
    }
}
