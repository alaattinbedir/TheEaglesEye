//
//  AppDelegate.swift
//  EaglesEye
//
//  Created by Alaattin Bedir on 10/29/16.
//  Copyright © 2016 Magic Lump Games. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import AVFoundation
import AdSupport
import AdSupport
import AudioToolbox
import CoreGraphics
import CoreGraphics
import CoreLocation
import CoreMedia
import CoreTelephony
import CoreTelephony
import CoreVideo
import Foundation
import GLKit
import MediaPlayer
import MediaPlayer
import MessageUI
import OpenGLES
import QuartzCore
import SafariServices
import StoreKit
import StoreKit
import SystemConfiguration
import SystemConfiguration
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // Configure tracker from GoogleService-Info.plist.
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        // Optional: configure GAI options.
        let gai = GAI.sharedInstance()
        gai?.trackUncaughtExceptions = true  // report uncaught exceptions
        gai?.logger.logLevel = GAILogLevel.verbose  // remove before app release
        
        Fabric.with([Crashlytics.self])
        
        HeyzapAds.start(withPublisherID: "1f256a74c0178cb111a2cde78a93d2a2")
        
        
        HeyzapAds.presentMediationDebugViewController()
        
        return true
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

