//
//  GTFileLogger.h
//  GoTenna
//
//  Created by Julietta Yaunches on 6/18/15.
//  Copyright (c) 2015 goTenna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFFileLogger : NSObject

- (id)initWithTimestamps:(BOOL)withTimestamps;
- (void)log:(NSString *)baseLog, ... NS_FORMAT_FUNCTION(1,2);

- (NSArray *)allLogs;
- (NSArray *)latestLogs;
- (void)truncateLog;

- (NSString *)directoryPath;

- (NSString *)logFilePath;
- (void)writeQueued;
@end
