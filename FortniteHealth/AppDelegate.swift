//
//  AppDelegate.swift
//  FortniteHealth
//
//  Created by Tom Macgowan on 18/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
        global.timeLeft = CFAbsoluteTimeGetCurrent()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        global.timeReturned = CFAbsoluteTimeGetCurrent()
        global.downTime = global.timeReturned - global.timeLeft
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //only do this if game is currently on gamescreen
        if global.isPause == false
        {
            for i in 0...Int(global.downTime)
            {
                if Int(global.overallTime) + i < global.stormTimes[0]
                {
                    global.counter = global.counter - global.stormDamages[0]
                }
                else if Int(global.overallTime) + i < global.stormTimes[1]
                {
                    global.counter = global.counter - global.stormDamages[1]
                }
                else if Int(global.overallTime) + i < global.stormTimes[2]
                {
                    global.counter = global.counter - global.stormDamages[2]
                }
                else if Int(global.overallTime) + i < global.stormTimes[3]
                {
                    global.counter = global.counter - global.stormDamages[3]
                }
                else if Int(global.overallTime) + i < global.stormTimes[4]
                {
                    global.counter = global.counter - global.stormDamages[4]
                }
            }
            global.overallTime = global.overallTime + global.downTime
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

