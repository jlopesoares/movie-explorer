//
//  AppDelegate.swift
//  MovieExplorer
//
//  Created by João Pedro on 08/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: AppCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let tabController = UITabBarController()
        
        // send that into our coordinator so that it can display view controllers
        coordinator = AppCoordinator(tabBarController: tabController)
        
        // tell the coordinator to take over control
        coordinator?.start()
        
        // create a basic UIWindow and activate it
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
        
        return true
    }
}

