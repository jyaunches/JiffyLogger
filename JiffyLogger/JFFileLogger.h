//
//  GTFileLogger.h
//  GoTenna
//
//  Created by Julietta Yaunches on 6/18/15.
//  Copyright (c) 2015 goTenna. All rights reserved.
//

#import <Foundation/Foundation.h>

static dispatch_queue_t GTCommandFileLogging() {
    static dispatch_queue_t commandFileLogging;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commandFileLogging = dispatch_queue_create("com.GT.GTCommandFileLogging", DISPATCH_QUEUE_SERIAL);
    });

    return commandFileLogging;
}

@interface JFFileLogger : NSObject

- (id)initWithFileName:(NSString *)filename andSeparator:(NSString *const)separator withTimestamps:(BOOL)withTimestamps;
- (void)log:(NSString *)baseLog, ... NS_FORMAT_FUNCTION(1,2);

- (NSArray *)allLogs;
- (NSArray *)latestLogs;
- (void)truncateLog;
- (NSString *)directory;
- (void)writeQueued;
@end
