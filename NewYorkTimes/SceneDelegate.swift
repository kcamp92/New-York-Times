//
//  SceneDelegate.swift
//  NewYorkTimes
//
//  Created by Krystal Campbell on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
           var TabNavigationController : UINavigationController!
             TabNavigationController = UINavigationController.init(rootViewController: BestSellersViewController())
             let Favorites = FavoritesViewController()
             let Settings = SettingsViewController()
             
             let tabBarController = UITabBarController()
             tabBarController.viewControllers = [TabNavigationController, Favorites,Settings]
             
             let item1 = UITabBarItem(title: "Best Sellers", image: UIImage(named: "award"), tag: 0)
             
            let item2 = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite"), tag: 1)
        
       
        
            let item3 = UITabBarItem(title: "Settings", image:UIImage(named: "gearbox") , tag: 2)
        
        
             TabNavigationController.tabBarItem = item1
             Favorites.tabBarItem = item2
             Settings.tabBarItem = item3
             
             UITabBar.appearance().tintColor = UIColor(red: 0/255.0, green: 146/255.0, blue: 248/255.0, alpha: 1.0)
            
             
             guard let windowScene = (scene as? UIWindowScene) else { return }
             window = UIWindow(frame: UIScreen.main.bounds)
             window?.windowScene = windowScene
             window?.rootViewController = tabBarController
             window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

