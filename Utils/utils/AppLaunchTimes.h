//
//  AppLaunchTimes.h
//  mobileguard
//
//  Created by MikeLin on 8/11/14.
//  Copyright (c) 2014 Tapas Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppLaunchTimes : NSObject
+ (void)update;
+ (NSInteger)times;
+ (NSInteger)timesInToday;
@end
