//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 19/08/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appRouter: AppRouter!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appRouter = ApplicationAssembly.appRouter
        appRouter.openMainModule()
        
        return true
    }
}

