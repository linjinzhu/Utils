//
//  NSDate+Helper.m
//  mobileguard
//
//  Created by MikeLin on 14-5-14.
//  Copyright (c) 2014年 Baidu International Technology (Shenzhen) Co., LTD. All rights reserved.
//

#import "NSDate+Helper.h"

#ifndef __IPHONE_7_0
#define NSCalendarUnitYear NSYearCalendarUnit
#define NSCalendarUnitMonth NSMonthCalendarUnit
#define NSCalendarUnitDay NSDayCalendarUnit
#endif

@implementation NSDate (Helper)

#pragma mark - public

+ (BOOL)is24HourTime
{
    NSString *formatStringForHours = [NSDateFormatter
                                      dateFormatFromTemplate:@"j"
                                      options:0
                                      locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    return (containsA.location == NSNotFound);
}

+ (NSDate*)dateFromString:(NSString*)string format:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (format != nil) {
        [dateFormatter setDateFormat:format];
    }
    return [dateFormatter dateFromString:string];
}

+ (NSString*)stringFromDate:(NSDate*)date format:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (format != nil) {
        [dateFormatter setDateFormat:format];
    }
    return [dateFormatter stringFromDate:date];
}

+ (NSDate*)beginningOfTomorrow
{
    NSDate *now = [NSDate date];
    NSTimeInterval timeInterval = [[now endOfDay] timeIntervalSinceDate:now]+1;
    return [now dateByAddingTimeInterval:timeInterval];
}

- (BOOL)isToday
{
    if (self == nil) {
        return NO;
    }

    NSDate *today = [NSDate date];
    if ([self isDateBetweenStartDate:[today beginningOfDay] andEndDate:[today endOfDay]]) {
        return YES;
    }

    return NO;
}

- (NSDate*)tomorrow
{
    NSTimeInterval timeInterval = [self timeIntervalSinceReferenceDate];
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval+24*3600];
}

- (NSDate*)yesterday
{
    NSTimeInterval timeInterval = [self timeIntervalSinceReferenceDate];
    return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval-24*3600];
}

- (NSString*)formatDate:(NSDate*)date withFormat:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

- (NSDate*)beginningOfDay
{
    return [self setHour:0 minute:0 second:0];
}

- (NSDate*)endOfDay
{
    return [self setHour:23 minute:59 second:59];
}

- (NSInteger)monthRestDayNumber:(NSDate*)endDate
{
    NSDate *startDate = [NSDate date];

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:startDate toDate:endDate options:0];
    NSInteger days = [components day];

    // 今天日期和本月结束日期之差，加上今天
    return days + 1;
}

- (NSDate *)beginningOfMonth
{
    NSDate *date = [self dateAfterDay:-[[self components] day] + 1];
    return [date setHour:0 minute:0 second:0];
}

//该月的最后一天
- (NSDate *)endOfMonth
{
    NSDate *date = [[[self beginningOfMonth] dateAfterMonth:1] dateAfterDay:-1];
    return [date setHour:23 minute:59 second:59];
}

- (NSDate*)dateByAddingYear:(NSInteger)year
                      month:(NSInteger)month
                        day:(NSInteger)day
                       hour:(NSInteger)hour
                     minute:(NSInteger)minute
                     second:(NSInteger)second
{
    NSDateComponents *add = [[NSDateComponents alloc] init];
    add.year = year;
    add.month = month;
    add.day = day;
    add.hour = hour;
    add.minute = minute;
    add.second = second;
    return [[NSCalendar currentCalendar] dateByAddingComponents:add toDate:self options:0];
}

- (NSDate*)setYear:(NSInteger)year
             month:(NSInteger)month
               day:(NSInteger)day
              hour:(NSInteger)hour
            minute:(NSInteger)minute
            second:(NSInteger)second
{
    NSDateComponents *comps = [self components];
    if (year >= 0) {
        comps.year = year;
    }
    if (month >= 0) {
        comps.month = month;
    }
    if (day >= 0) {
        comps.day = day;
    }
    if (hour >= 0) {
        comps.hour = hour;
    }
    if (minute >= 0) {
        comps.minute = minute;
    }
    if (second >= 0) {
        comps.second = second;
    }

    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

- (NSDate*)setHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    return [self setYear:-1 month:-1 day:-1 hour:hour minute:minute second:second];
}

- (NSDate*)setDay:(NSInteger)day
{
    return [self setYear:-1 month:-1 day:day hour:-1 minute:-1 second:-1];
}

- (NSDate*)setMonth:(NSInteger)month
{
    return [self setYear:-1 month:month day:-1 hour:-1 minute:-1 second:-1];
}

- (BOOL)isDateBetweenStartDate:(NSDate*)startDate andEndDate:(NSDate*)endDate
{
    NSTimeInterval interval = [self timeIntervalSince1970];
    if ([startDate timeIntervalSince1970] <= interval
        && interval <= [endDate timeIntervalSince1970]) {
        return YES;
    }
    return NO;
}

#pragma mark - private

//month个月后的日期
- (NSDate *)dateAfterMonth:(NSInteger)month
{
    return [self dateByAddingYear:0 month:month day:0 hour:0 minute:0 second:0];
}

// 返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(NSInteger)day
{
    return [self dateByAddingYear:0 month:0 day:day hour:0 minute:0 second:0];
}

- (NSDateComponents*)components
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:0xFFFF fromDate:self];
}

- (NSDateComponents *)componentsWithYearMonthDayFlags
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    return [currentCalendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                              fromDate:self];
}

@end
