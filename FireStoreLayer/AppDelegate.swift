//
//  AppDelegate.swift
//  FireStoreLayer
//
//  Created by Abdelrahman Sobhy on 3/13/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirestoreServiceLayer.shared.firestoreConfugeration()
        return true
    }
}

