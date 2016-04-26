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
        let navigationVC = UINavigationController(rootViewController:tableVC)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        return true
    }
}

