//
//  AppDelegate.m
//  Fleem
//
//  Created by Jun Suh Lee on 2/7/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
@import UIKit;

@implementation AppDelegate
@synthesize submitFromPickerView;




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"cHTfniTBTJKAktthBRjpuOJ1LfR0MwlhpdGXk5GL"
                  clientKey:@"xFBCkK00UchBw6w4aKSbh8WcsDgYNiA8iMtpXbUW"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
   
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];

  
    
 
    
    

    return YES;
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    //Tell Parse about the device token.
    [PFPush storeDeviceToken:newDeviceToken];
    //Subscribe to the global broadcast channel.
    [PFPush subscribeToChannelInBackground:@""];
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotifications:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
