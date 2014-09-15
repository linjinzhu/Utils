//
//  NSDate+Helper.h
//  mobileguard
//
//  Created by MikeLin on 14-5-14.
//  Copyright (c) 2014年 Baidu International Technology (Shenzhen) Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

+ (BOOL)is24HourTime;
+ (NSDate*)dateFromString:(NSString*)string format:(NSString*)format;
+ (NSString*)stringFromDate:(NSDate*)date format:(NSString*)format;
+ (NSDate*)beginningOfTomorrow;

- (BOOL)isToday;
- (NSDate*)tomorrow;
- (NSDate*)yesterday;
- (NSString*)formatDate:(NSDate*)date withFormat:(NSString*)format;
- (NSDate*)beginningOfDay;
- (NSDate*)endOfDay;
- (NSDate*)beginningOfMonth;
- (NSDate*)endOfMonth;
- (NSDate *)dateAfterMonth:(NSInteger)month;
- (NSInteger)monthRestDayNumber:(NSDate*)endDate;

/**
 * set the components of the date, -1 means do not change the value.
 */
- (NSDate*)setYear:(NSInteger)year
             month:(NSInteger)month
               day:(NSInteger)day
              hour:(NSInteger)hour
            minute:(NSInteger)minute
            second:(NSInteger)second;

/**
 * add the components of the date, 0 means do not change the value.
 */
- (NSDate*)dateByAddingYear:(NSInteger)year
                      month:(NSInteger)month
                        day:(NSInteger)day
                       hour:(NSInteger)hour
                     minute:(NSInteger)minute
                     second:(NSInteger)second;

- (NSDate*)setHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
- (NSDate*)setDay:(NSInteger)day;
- (NSDate*)setMonth:(NSInteger)month;
- (BOOL)isDateBetweenStartDate:(NSDate*)startDate andEndDate:(NSDate*)endDate;
- (NSDateComponents*)components;
- (NSDateComponents *)componentsWithYearMonthDayFlags;

@end
