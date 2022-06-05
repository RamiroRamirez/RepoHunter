//
//  AppDelegate.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 04.06.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
         self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        self.appCoordinator = AppCoordinator(mainNavigationController: navigationController)
        
        self.appCoordinator?.start()
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }
}

