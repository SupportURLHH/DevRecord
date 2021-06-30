//
//  AppDelegate.swift
//  Integration
//
//  Created by 范庆宇 on 2021/6/22.
//

import UIKit
import PopInterrupter

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        PopInterrupter.load()
        
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = Color.white
        let vc = ViewController()
        let nav = QYNavigationController.init(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
        
    }
    
}

