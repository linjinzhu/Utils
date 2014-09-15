//
//  ScheduledTask.h
//  iOSSystemAccelerator
//
//  Created by MikeLin on 14-4-20.
//  Copyright (c) 2014年 MikeLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScheduledTask : NSTimer
@property CGFloat timerInterval;
@property CGFloat timeUsed;


/*!
 Start a task but infact it is a timer.
 @param seconds         Used time in the hole task.
 @param timeInterval    interval between prerior and last.
 @param updateBlock
 @param finishBlock
 */
- (void)startTaskWithinSeconds:(NSTimeInterval)seconds
                  timeInterval:(NSTimeInterval)timeInterval
                   updateBlock:(void(^)(NSInteger step, CGFloat progress))updateBlock
                   finishBlock:(void(^)())finishBlock
                   cancelBlock:(void(^)())cancelBlock;
/*!
 Will set the fireDate to distanceFutureDate when call this method.
 */
- (void)cancel;
/*!
 Will call timer's invalidate method so that you will can't fire the timer agian.
 */
- (void)destroy;
@end
