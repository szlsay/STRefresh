//
//  AppDelegate.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/11.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        
        let tableVC = TableViewController()
        tableVC.title = "Table"
        let navigationVC0 = UINavigationController(rootViewController:tableVC)

        let collectionVC = CollectionViewController()
        collectionVC.title = "Collection"
        let navigationVC1 = UINavigationController(rootViewController:collectionVC)

        let webVC = WebViewController()
        webVC.title = "Web"
        let navigationVC2 = UINavigationController(rootViewController:webVC)

        let tabbarVC = UITabBarController()
        tabbarVC.viewControllers = [navigationVC0, navigationVC1, navigationVC2]

       
        window?.rootViewController = tabbarVC
        window?.makeKeyAndVisible()
        return true
    }
}

