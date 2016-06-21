//
//  AppDelegate.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
  
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // 注册一个通知
        NSNotificationCenter.defaultCenter().addObserver("", selector: #selector(AppDelegate.switchRootViewController(_:)), name:switchRootViewControllerKey, object: nil)
        
        // 设置导航条和tabBar的外观
        // 因为外观一旦设置则，全局有效,并且只需要设置一次，所以didFinishLaunchingWithOptions设置
        setupAppearance()
        
        window = UIWindow()
        window?.frame = UIScreen.mainScreen().bounds
        window?.rootViewController = defaultViewController()
        window?.makeKeyAndVisible()
        
    
        return true
    }

    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
   private func setupAppearance()
    {
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
    }
    
    func switchRootViewController(notify:NSNotification)
    {
        print(notify.object)
        if notify.object as! Bool
        {
            window?.rootViewController = ZEMainViewController();
        }else
        {
            window?.rootViewController = ZEWelcomeViewController();
        }
    }
    /**
     用于获取默认界面
     */
    private func defaultViewController() -> UIViewController
    {
        // 1.检查用户是否登录
        if  (ZEUserAccount.loadAccount() != nil)  {
            return isNewupdate() ? ZENewfeatureViewController():ZEWelcomeViewController()
        }
        return ZEMainViewController()
    }
    
    private func isNewupdate() -> Bool
    {
        //1.判断当前版本
        let currentVersio = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        //2.获取以前的软件的版本号
        let sandboxVersion = NSUserDefaults.standardUserDefaults().objectForKey("CFBundleShortVersionString") as? String ?? ""
        print("currentVersion = \(currentVersio) sanbox = \(sandboxVersion)")
        // 3.比较当前版本号和以前版本号【
        if currentVersio.compare(sandboxVersion) == NSComparisonResult.OrderedDescending {
            // 3.1 存储最新的版本号
            NSUserDefaults.standardUserDefaults().setValue(currentVersio, forKey: "CFBundleShortVersionString")
            return true
        }
        return false
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

