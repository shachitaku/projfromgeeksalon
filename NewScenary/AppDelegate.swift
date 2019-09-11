//
//  AppDelegate.swift
//  NewScenary
//
//  Created by Takumi Kimura on 2018/02/23.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//

import NCMB
import UIKit
import GoogleMaps
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyAnP_kL8M3xAkjHNU2vgmqsPsWi8Wv6NOw");
        GMSPlacesClient.provideAPIKey("AIzaSyAnP_kL8M3xAkjHNU2vgmqsPsWi8Wv6NOw");
 
        //Databaseとの接続コード
    NCMB.setApplicationKey("5ee89f24f08a874a069948e5ac5d508dbe7f8957a0bac52d6ccd459642bbcc82", clientKey: "3305ac6caae748938138f7388ea28e2d81b7c0086c0c65c340dd99ea153a1ab8")
        
        let ud = UserDefaults.standard
        let isLogin = ud.bool(forKey: "isLogin")
        
        if isLogin == true {
            //ログイン中だったら
            //iPhoneのサイズに合わせてWindowを作る
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            //何かIDをついているものを起動する
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
        } else {
            //ログインしていなかったら
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            //何かIDをついているものを起動する
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
    
        }
        
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

