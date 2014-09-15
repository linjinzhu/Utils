//
//  AppLaunchTimes.m
//  mobileguard
//
//  Created by MikeLin on 8/11/14.
//  Copyright (c) 2014 Tapas Mobile. All rights reserved.
//

#import "AppLaunchTimes.h"
#import "NSDate+Helper.h"

NSString *const kALTTimes = @"kALTTimes";
NSString *const kALTTimesInToday = @"kALTTimesInToday";
NSString *const kALTLastDateForLaunch = @"kALTLastDateForLaunch";

@implementation AppLaunchTimes

+ (void)update
{
    // Launch times in today
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastLaunchDate = [userDefaults objectForKey:kALTLastDateForLaunch];
    if ([lastLaunchDate isToday]) {
        NSInteger times = [[userDefaults objectForKey:kALTTimesInToday] integerValue];
        [userDefaults setObject:@(++times) forKey:kALTTimesInToday];
    } else {
        [userDefaults setObject:@(1) forKey:kALTTimesInToday];
    }
    [userDefaults setObject:[NSDate date] forKey:kALTLastDateForLaunch];

    // Launch times when user install the application
    NSInteger times = [[userDefaults objectForKey:kALTTimes] integerValue];
    [userDefaults setObject:@(++times) forKey:kALTTimes];

    NSLog(@"Last launch date : %@ and this launch date : %@", lastLaunchDate, [NSDate date]);
}

+ (NSInteger)times
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kALTTimes] integerValue];
}

+ (NSInteger)timesInToday
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kALTTimesInToday] integerValue];
}

@end

