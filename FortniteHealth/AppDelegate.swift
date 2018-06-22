//
//  AppDelegate.swift
//  FortniteHealth
//
//  Created by Tom Macgowan on 18/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound];

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong with notification authorisation")
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
       global.fromBackground = false
        //NSLog("WillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //NSLog("DidEnterBackground")
        if global.gameOn == true
        {
            
            assignNotification()
           
        }
        global.fromBackground = true
        global.timeLeft = CFAbsoluteTimeGetCurrent()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        //NSLog("WillEnterForeground")
        
        global.timeReturned = CFAbsoluteTimeGetCurrent()
        global.downTime = global.timeReturned - global.timeLeft
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //NSLog("didBecomeActive")
        //only do this if game is currently on gamescreen
        center.removeAllPendingNotificationRequests()
        if global.isPause == false && global.fromBackground == true
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

    func assignNotification()
    {
        //calculate storm times
        let delayStorm1 = Double(global.stormTimes[0] - Int(global.overallTime))
        let delayStorm2 = Double(global.stormTimes[1] - Int(global.overallTime))
        let delayStorm3 = Double(global.stormTimes[2] - Int(global.overallTime))
        let delayStorm4 = Double(global.stormTimes[3] - Int(global.overallTime))
        let delayGameEnd = Double(global.stormTimes[4] - Int(global.overallTime))
        var delayShot: Double = -1
        if global.hasShot == 1
        {
            delayShot = Double(global.shotTime - Int(global.overallTime))
        }
        /*
        NSLog("delayStorms: %f %f %f %f", delayStorm1,delayStorm2,delayStorm3,delayStorm4)
        NSLog("delayEndGame: %f", delayGameEnd)
        NSLog("delayShot: %f", delayShot)
         */
 
 
        
        var gameTime = Int(global.overallTime)
        var lifeLeft = global.counter
        var delayHealthWarning = 0
        var delayDeath = 0
        
        
        
        if lifeLeft < 20 //dont notify if life left is under warning level already
        {
           delayHealthWarning = -1
        }
        while lifeLeft > 0
        {
            if gameTime <= global.stormTimes[0]
            {
                lifeLeft = lifeLeft - global.stormDamages[0]
            }
            else if gameTime <= global.stormTimes[1]
            {
                lifeLeft = lifeLeft - global.stormDamages[1]
            }
            else if gameTime <= global.stormTimes[2]
            {
                lifeLeft = lifeLeft - global.stormDamages[2]
            }
            else if gameTime <= global.stormTimes[3]
            {
                lifeLeft = lifeLeft - global.stormDamages[3]
            }
            else if gameTime <= global.stormTimes[4]
            {
                lifeLeft = lifeLeft - global.stormDamages[4]
            }
            else if gameTime > global.stormTimes[4]
            {
                lifeLeft = 0
            }
            gameTime = gameTime + 1
            delayDeath = delayDeath + 1
            if lifeLeft >= 20 //health level required for warning
            {
                delayHealthWarning = delayHealthWarning + 1
            }
        }
       
       
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized
            {
                // If Notifications allowed
                if delayStorm1 > 0 //change these to soemthing like 30 so it doesnt notify as soon as they close the app
                {
                     self.requestNotification(identifier: "notifyFirstStorm", title: "Storm Warning", body: "You've entered the 1st storm", delay: delayStorm1)
                }
                if delayStorm2 > 0
                {
                    self.requestNotification(identifier: "notifySecondStorm", title: "Storm Warning", body: "You've entered the 2nd storm", delay: delayStorm2)
                }
                if delayStorm3 > 0
                {
                    self.requestNotification(identifier: "notifyThirdStorm", title: "Storm Warning", body: "You've entered the 3rd storm", delay: delayStorm3)
                }
                if delayStorm4 > 0
                {
                self.requestNotification(identifier: "notifyFourthStorm", title: "Storm Warning", body: "You've entered the final storm", delay: delayStorm4)
                }
                if delayHealthWarning > 0
                {
                self.requestNotification(identifier: "notifyLowHealth", title: "Health Warning", body: "You're on low health", delay: Double(delayHealthWarning))
                }
                if delayShot > 0 && delayShot < Double(delayDeath)//dont change this though
                {
                    self.requestNotification(identifier: "notifyShot", title: "Alert", body: "Its shot time", delay: Double(delayShot))
                }
                
                self.requestNotification(identifier: "notifyGameEnd", title: "Alert", body: "The game just ended", delay: Double(delayGameEnd))
                
                if delayDeath > 0 && Double(delayDeath) < delayGameEnd - 5
                {
                    self.requestNotification(identifier: "notifyDeath", title: "Alert", body: "You just died", delay: Double(delayDeath))
                }
                
            }
        }
    }
    
        
    func requestNotification(identifier: String, title: String, body: String, delay: Double)
    {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request, withCompletionHandler:
        { (error) in
            if error != nil
            {
                // Something went wrong
            }
        })
    }

}

