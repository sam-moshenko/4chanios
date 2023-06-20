//
//  AppDelegate.swift
//  FourChan
//
//  Created by Semen Lebedev on 19.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }

    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        //window?.overrideUserInterfaceStyle = .dark
        window?.rootViewController = ThreadsViewController()
    }
}

