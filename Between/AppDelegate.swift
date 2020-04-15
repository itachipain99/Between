//
//  AppDelegate.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 1/30/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = Realm.Configuration( schemaVersion: 12, migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 12) {
                         // Nothing to do!
            }
        })
       // print(Realm.Configuration.defaultConfiguration.fileURL!)
        print( Realm.Configuration.defaultConfiguration.fileURL!)
//        let filURL = URL(fileURLWithPath: "/Users/nguyenminhhieu/Desktop/Between/DatabaseApp/database.realm")
//        Realm.Configuration.defaultConfiguration = config
//        do{
//            Realm.Configuration.defaultConfiguration.fileURL! = filURL
//        }
//        catch{
//             print(error)
//        }
        let configCheck = Realm.Configuration()
        do {
            let fileUrlIs = try schemaVersionAtURL(configCheck.fileURL!)
            print("schema version \(fileUrlIs)")
        } catch {
            print(error)
        }
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

