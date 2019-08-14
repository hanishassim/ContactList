//
//  AppDelegate.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    fileprivate func initIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ContactInfoService.shared.copyJsonIfNeeded()
        
        let cl = ContactListVC()
        let navVC = UINavigationController(rootViewController: cl)
        navVC.navigationBar.tintColor = accentColor
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        
        initIQKeyboardManager()
        
        return true
    }
}

