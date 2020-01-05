//
//  AppDelegate.swift
//  AppStore
//
//  Created by Faiz Sharief on 03/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

//    var popularApplications : [Application] = []
//    var featuredApplications : [Application] = []
    var allDownloadedApps : [Application] = []
    
    var noOfRows : [TableRowModel]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        downloadInitialApps()
        
        return true
    }
    
    func downloadInitialApps() {
        // Create app objects initially
        // Call service to download applications
        let service = AppService()
        service.download { (appList) in
            
            // check for empty apps
            guard let recievedApps = appList else {
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil, userInfo: ["hasData" : false])
                return
            }
            
            self.allDownloadedApps = recievedApps

            var popApps1 : [Application] = []
            var popApps2 : [Application] = []
            var featApps1 : [Application] = []
            var featApps2 : [Application] = []

            for i in 0...2{
                popApps1.append(recievedApps[i])
            }
            for i in 3...5{
                popApps2.append(recievedApps[i])
            }
            
            for i in 6...8{
                featApps1.append(recievedApps[i])
            }
            for i in 9...11{
                featApps2.append(recievedApps[i])
            }
            let firstRowFirstCell = CollectionCellModel(applications: popApps1)
            let firstRowSecondCell = CollectionCellModel(applications: popApps2)
            
            let firstRow = TableRowModel(collectionCells: [firstRowFirstCell, firstRowSecondCell])
            
            let secondRowFirstCell = CollectionCellModel(applications: featApps1)
            let secondRowSecondCell = CollectionCellModel(applications: featApps2)
            
            let secondRow = TableRowModel(collectionCells: [secondRowFirstCell, secondRowSecondCell])
            
            self.noOfRows = [firstRow,secondRow]
            
            
//            // Create popular apps
//            for i in 0...5{
//                self.popularApplications.append(recievedApps[i])
//            }
//            // Create featured apps
//            for i in 6...11{
//                self.featuredApplications.append(recievedApps[i])
//            }
            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil, userInfo: ["hasData" : true])
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

