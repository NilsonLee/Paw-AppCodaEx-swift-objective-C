//
//  AppDelegate.m
//  Paws-2
//
//  Created by 李祐昇 on 2015/10/25.
//  Copyright © 2015年 Nilson Lee. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse.h>
#import <ParseUI.h>
#import "PFQTableViewController.h"

#define TABLEVC_TITLE @"Paws"
#define PARSE_PAWS_APPLICATIONID @"Z0gaO5Zyug9GIGuEyzyISgc0Vbwz0wNnRMGDCB23"
#define PARSE_PAWS_CLIENTKEY @"FbkY1ioP5ehsyqNiWCtdy00g4s9PreHHppv2mx3i"

//#define BASE_URL @"http://class.softarts.cc/PushMessage"
//#define SENDMESSAGE_URL [BASE_URL stringByAppendingPathComponent:@"sendMessage.php"]




@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Initialize Parse.
    //[Parse enableLocalDatastore];
    [Parse setApplicationId:PARSE_PAWS_APPLICATIONID
                  clientKey:PARSE_PAWS_CLIENTKEY];
    
    PFQTableViewController * catTableVC = [[PFQTableViewController new] initWithClassName:PARSE_CLASS_NAME];
    catTableVC.title = TABLEVC_TITLE;
    
    UINavigationBar.appearance.tintColor = [UIColor colorWithRed:0.05 green:0.47 blue:0.91 alpha:1.0];
    UINavigationBar.appearance.barTintColor = [UIColor colorWithRed:0.05 green:0.47 blue:0.91 alpha:1.0];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"YOURFONT" size:14], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UINavigationController * navigationVC = [[UINavigationController new]initWithRootViewController: catTableVC];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = navigationVC;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
