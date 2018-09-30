//
//  MainAppRouter.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 19/08/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import UIKit

class MainAppRouter {
    
    private(set) var window: UIWindow!

    private func openModule(_ controller: UIViewController) {
        createWindowIfNeeded()
        window.backgroundColor = UIColor.white
        window.rootViewController = controller
        makeKeyAndVisibleIfNeeded()
    }
    
    private func createWindowIfNeeded() {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
    }
    
    private func makeKeyAndVisibleIfNeeded() {
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }
    }
}

extension MainAppRouter: AppRouter {
    
    func openMainModule() {
        openModule(CurrencyConverterAssembly.createModule())
    }
}
