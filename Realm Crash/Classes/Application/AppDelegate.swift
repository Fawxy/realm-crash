//
//  AppDelegate.swift
//  Instructor
//
//  Created by Steve Smith on 08/02/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        NetworkLayerConfiguration.setup()
        configureRealm()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = initialViewController()
        window?.makeKeyAndVisible()

        return true
    }

    fileprivate func configureRealm() {
        // Realm
        let directory: URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.chrisbyatt.realmcrash")!
        let realmPath: URL = directory.appendingPathComponent("db.realm")

        let config = Realm.Configuration(fileURL: realmPath)

        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
    }
}

// MARK: Utilities
extension AppDelegate {
    class func sharedDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func initialViewController() -> UIViewController {
            let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            return dashboardStoryboard.instantiateInitialViewController()!
    }
}
