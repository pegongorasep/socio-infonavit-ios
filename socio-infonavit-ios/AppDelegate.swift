//
//  AppDelegate.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
var window:UIWindow?

    static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().tintColor = UIColor.white

        SVProgressHUD.setBackgroundColor(.clear)
        
        window?.rootViewController = SplashScreenVC()
        window?.makeKeyAndVisible()

        return true
    }
    
    
    
    static func login(with user: UserResponse) {
        AppDelegate.user = user
        AppDelegate.isLoggedIn = true
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "drawerController") as UIViewController
        AppDelegate.standard.window?.rootViewController = vc
    }
    
    static func logOut() {
        AppDelegate.user = nil
        AppDelegate.isLoggedIn = false
        AppDelegate.standard.window?.rootViewController = LoginVC()
    }
    
    static func saveToken(token: String) {
        AppDelegate.token = token
    }
    
    static func getToken() -> String? {
        return AppDelegate.token
    }
    
    static var user: UserResponse? {
        get { return loadObject(key: "user") }
        set { return saveObject(newValue, key: "user") }
    }
    
    static var token: String? {
        get { UserDefaults.standard.string(forKey: "token") }
        set { return UserDefaults.standard.set(newValue, forKey: "token") }
    }
    
    static var isLoggedIn: Bool {
        get { return UserDefaults.standard.bool(forKey: "isLoggedIn") }
        set { UserDefaults.standard.set(newValue, forKey: "isLoggedIn") }
    }
            
    private static func saveObject<T: Codable>(_ object: T, key: String) {
        if let encoded = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private static func loadObject<T: Codable>(key: String) -> T? {
        if let savedObject = UserDefaults.standard.object(forKey: key) as? Data {
            return try? JSONDecoder().decode(T.self, from: savedObject)
        } else {
            return nil
        }
    }
}

