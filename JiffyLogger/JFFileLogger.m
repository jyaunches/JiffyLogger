//
//  GTFileLogger.m
//  GoTenna
//
//  Created by Julietta Yaunches on 6/18/15.
//  Copyright (c) 2015 goTenna. All rights reserved.
//

#import <ObjectiveSugar/ObjectiveSugar.h>
#import "JFFileLogger.h"
#import "NSDate+JFLogging.h"

@interface JFFileLogger ()
@property(nonatomic, strong) NSMutableArray *logQueue;
@property(nonatomic, strong) NSString *const separator;
@property(nonatomic) BOOL withTimestamps;
@property(nonatomic, copy) NSString *filename;
@end

NSString *const LOG_DIRECTORY = @"jiffy_logs";

@implementation JFFileLogger

- (id)initWithFileName:(NSString *)filename andSeparator:(NSString *const)separator withTimestamps:(BOOL)withTimestamps {
    self = [super init];
    self.separator = separator;
    self.filename = filename;
    self.logQueue = [NSMutableArray array];
    self.withTimestamps = withTimestamps;
    [self createLogFile];
    return self;
}

- (void)createLogFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if(![fileManager fileExistsAtPath:self.directory isDirectory:nil]){
        [fileManager createFileAtPath:self.directory contents:nil attributes:nil];
    }
}

- (void)log:(NSString *)firstArg, ...{
    NSMutableArray *theArgs = [NSMutableArray array];

    va_list args;
    va_start(args, firstArg);

    NSArray *array = [firstArg split:@"%"];
    NSUInteger numberOfArgs = [array count] - 1;

    for (int i = 1; i <= numberOfArgs; i++){
        NSString *arg = va_arg(args, NSString*);
        [theArgs addObject:[arg copy]];
    }

    NSString* theLog;
    if(theArgs.count > 0){
        NSArray* a = [theArgs arrayByAddingObjectsFromArray:@[@"X",@"X",@"X",@"X",@"X",@"X",@"X",@"X",@"X",@"X"]];
        theLog = [NSString stringWithFormat:firstArg, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10] ];
    }else{
        theLog = firstArg;
    }

    va_end(args);

    if(self.withTimestamps){
        theLog = [NSString stringWithFormat:@"%@ - %@", [NSDate nowForLogs], theLog];
    }

    [self.logQueue addObject:theLog];

    if (self.logQueue.count >= 50) {
        [self writeQueued];
    }
}

- (void)truncateLog {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:self.directory error:nil];
    [self createLogFile];
}

- (NSArray *)latestLogs {
    return [[self allLogs] take:400];
}

- (NSArray *)allLogs {
    NSArray *logs = @[];
    NSString *contentsOfLogFile = [NSString stringWithContentsOfFile:self.directory encoding:NSUTF8StringEncoding error:nil];
    if (contentsOfLogFile != nil) {
        logs = [contentsOfLogFile split:self.separator];
    }
    return [logs reverse];
}

- (void)writeQueued {
    NSMutableArray *logsToWrite = [self.logQueue copy];
    [self.logQueue removeAllObjects];
    dispatch_async(GTCommandFileLogging(), ^{
        NSMutableString *result = [@"" mutableCopy];
        [logsToWrite each:^(NSString *logEntry) {
            [result appendString:[NSString stringWithFormat:@"%@%@", logEntry, self.separator]];
        }];
        
        NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];

        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.directory];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];
    });
}

- (NSString *)directory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    return [NSString stringWithFormat:@"%@/%@/%@", documentsDirectory, LOG_DIRECTORY, self.filename];
}
@end
