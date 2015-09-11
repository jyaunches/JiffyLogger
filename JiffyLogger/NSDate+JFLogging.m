//
//  Blah.m
//  JiffyLogger
//
//  Created by Julietta Yaunches on 9/9/15.
//  Copyright (c) 2015 yaunches. All rights reserved.
//

#import "NSDate+JFLogging.h"

@implementation NSDate (GFLogging)
+ (NSString *)nowForLogs {
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM/dd-HH:mm:ss-SSS"];
    return [formatter stringFromDate:[NSDate date]];
}
@end
