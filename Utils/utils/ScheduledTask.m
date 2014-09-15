//
//  ScheduledTask.m
//  iOSSystemAccelerator
//
//  Created by MikeLin on 14-4-20.
//  Copyright (c) 2014年 MikeLin. All rights reserved.
//

#import "ScheduledTask.h"

#pragma mark - TimerUtil

@interface TimerUtil : NSObject
@property NSInteger index;          // current step index
@property NSInteger stepCount;      // total step
@property CGFloat timeInterval;
@end

@implementation TimerUtil
- (id)init
{
    self = [super init];
    if (self) {
        self.timeInterval = 0.1;
        self.index = 0;
    }
    return self;
}
@end


@interface ScheduledTask()
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) TimerUtil *timerUtil;
@property (strong, nonatomic) void (^updateBlock)(NSInteger step, CGFloat progress);
@property (strong, nonatomic) void (^finishBlock)(void);
@property (strong, nonatomic) void (^cancelBlock)(void);
@end

@implementation ScheduledTask

- (id)init
{
    self = [super init];
    if (self) {
        self.timerInterval = 0.5;
        self.timeUsed = 5;
        self.timerUtil = [[TimerUtil alloc] init];
    }
    return self;
}

- (void)startTaskWithinSeconds:(NSTimeInterval)seconds
                  timeInterval:(NSTimeInterval)timeInterval
                   updateBlock:(void(^)(NSInteger step, CGFloat progress))updateBlock
                   finishBlock:(void(^)())finishBlock
                   cancelBlock:(void(^)())cancelBlock;
{

    self.updateBlock = updateBlock;
    self.finishBlock = finishBlock;
    self.cancelBlock = cancelBlock;
    self.timerInterval = timeInterval;
    self.timeUsed = seconds;

    self.timerUtil.timeInterval = self.timerInterval;
    self.timerUtil.stepCount = (float)self.timeUsed / (float)self.timerInterval;
    self.timerUtil.index = 0;

    [self startTimer];
}

- (void)cancel
{
    [self stopTimer];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}


- (void)task
{
    self.timerUtil.index ++;
    if (self.updateBlock) {
        self.updateBlock(self.timerUtil.index, (float)self.timerUtil.index / (float)self.timerUtil.stepCount);
    }

    if (self.timerUtil.index >= self.timerUtil.stepCount && self.finishBlock) {
        [self stopTimer];
        self.finishBlock();
    }
}

#pragma mark - Timer

- (void)initTimer
{
    self.timer = [NSTimer timerWithTimeInterval:self.timerInterval
                                         target:self
                                       selector:@selector(task)
                                       userInfo:nil
                                        repeats:YES];
    if ([self.timer respondsToSelector:@selector(setTolerance:)]) {
#ifdef __IPHONE_7_0
        [self.timer setTolerance:self.timerInterval * 0.1];
#endif
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer
{
    if (!self.timer) {
        return;
    }
    // Change the fire date to distantFuture so as to run loop don't check the timer.
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)startTimer
{
    if (!self.timer) {
        [self initTimer];
    }
    // Change the fire date to distantPast so as to run loop check the timer.
    [self.timer setFireDate:[NSDate distantPast]];
}

- (void)destroy
{
    [self.timer invalidate];
}
@end
