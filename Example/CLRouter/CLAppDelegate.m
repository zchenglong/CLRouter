//
//  CLAppDelegate.m
//  CLRouter
//
//  Created by zhangchenglong on 01/15/2019.
//  Copyright (c) 2019 zhangchenglong. All rights reserved.
//

#import "CLAppDelegate.h"
#import "CLRouterManager.h"

@implementation CLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //动态注册路由表
    [[CLRouterManager sharedManager] registerRouterTableDynamic];
    //静态注册路由表
    [[CLRouterManager sharedManager] registerRouterTableWithFilePath:@"router_table_smart_tourism.json" bundle:[NSBundle mainBundle]];
    //或者使用plist
//    [[CLRouterManager sharedManager] registerRouterTableWithFilePath:@"router_table_smart_tourism.plist" bundle:[NSBundle mainBundle]];
    return YES;
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

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    CLRouterURLRequest *routerRequest = [[CLRouterURLRequest alloc]initWithURL:url];
    [[CLRouterManager sharedManager] openURLWithRouterRequest:routerRequest callback:^(NSURL *URL, NSError *error) {
        NSLog(@"%s | %@ | %@",__func__, URL, error);
    }];
    return YES;
}

@end
