//
//  AppDelegate.m
//  Utils
//
//  Created by MikeLin on 9/15/14.
//  Copyright (c) 2014 linjinzhu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AppLaunchTimes.h"
#import "ScheduledTask.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    // create window
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];

    // AppLaunchTimes

    // update launch time
    [AppLaunchTimes update];
    NSInteger times = [AppLaunchTimes times];
    NSInteger timesInToday = [AppLaunchTimes timesInToday];
    NSLog(@"application total launch times is : %ld, and today launch times is : %ld", (long)times, (long)timesInToday);


    // ScheduledTask
    ScheduledTask *task = [[ScheduledTask alloc] init];
    [task startTaskWithinSeconds:5.0f
                    timeInterval:1.0f
                     updateBlock:^(NSInteger step, CGFloat progress) {
                         NSLog(@"step : %ld, progress : %f", (long)step, progress);
                     }
                     finishBlock:^(void) {
                         NSLog(@"finished");
                     }
                     cancelBlock:^(void) {
                        NSLog(@"canceled");
                     }];


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
