Utils
=====

how manany utils do you have?
=============================

- AppLaunchTimes.h
- ScheduledTask.h

how to use?
===========

1. step 1 : Import headers.
2. step 2 : Write code where you need use.

Sample Code:

`AppLaunchTimes.h`
  
    // AppLaunchTimes
    // update launch time
    [AppLaunchTimes update];
    NSInteger times = [AppLaunchTimes times];
    NSInteger timesInToday = [AppLaunchTimes timesInToday];
    NSLog(@"application total launch times is : %ld, and today launch times is : %ld", (long)times, (long)timesInToday);
    

`ScheduledTask.h`

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
