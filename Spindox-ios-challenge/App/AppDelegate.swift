//
//  AppDelegate.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 05/10/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = BeerListViewController()
        let navigationView = UINavigationController(rootViewController: rootVC)
        self.window?.rootViewController = navigationView
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

