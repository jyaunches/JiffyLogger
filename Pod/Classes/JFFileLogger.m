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
@property(nonatomic) BOOL withTimestamps;
@property(nonatomic, copy) NSString *filename;
@property(nonatomic) BOOL autoWrite;
@end

NSString *const LOG_DIRECTORY = @"jiffy_logs";
NSString *const LOG_ENTRY_SEPARATOR_CHAR = @"%@$\n";

static dispatch_queue_t GTCommandFileLogging() {
    static dispatch_queue_t commandFileLogging;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commandFileLogging = dispatch_queue_create("com.GT.GTCommandFileLogging", DISPATCH_QUEUE_SERIAL);
    });

    return commandFileLogging;
}

@implementation JFFileLogger

- (id)initWithTimestamps:(BOOL)withTimestamps {
    self = [super init];
    self.filename = [NSStringFromClass ([self class]) lowercaseString];
    self.logQueue = [NSMutableArray array];
    self.autoWrite = false;
    self.withTimestamps = withTimestamps;
    [self createLogFile];
    return self;
}

- (void)createLogFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if(![fileManager fileExistsAtPath:[self directoryPath] isDirectory:nil]){
        NSError *error;
        [fileManager createDirectoryAtPath:[self directoryPath] withIntermediateDirectories:YES attributes:nil error:&error];
        if(error){
            NSLog(@"error creating directory");
        }
    }

    if(![fileManager fileExistsAtPath:[self logFilePath] isDirectory:nil]){
        [fileManager createFileAtPath:[self logFilePath] contents:nil attributes:nil];
    }
}
- (void)singleLog:(NSString *)baseLog  {
    NSString* theLog = baseLog;
    if(self.withTimestamps){
       theLog = [NSString stringWithFormat:@"%@ - %@", [NSDate nowForLogs], theLog];
    }

    [self.logQueue addObject:theLog];

    if ((self.logQueue.count >= 50) || (self.autoWrite)) {
        [self writeQueued];
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
        if (theArgs.count > 10 ) {
            @throw [NSException exceptionWithName:NSRangeException reason:@"Maximum of 10 arguments allowed" userInfo:@{@"collection": theArgs}];
        }
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
    [fileManager removeItemAtPath:self.logFilePath error:nil];
    [self createLogFile];
}

- (NSArray *)latestLogs {
    return [[self allLogs] take:400];
}

- (NSArray *)allLogs {
    NSMutableArray *logs = [@[] mutableCopy];
    NSString *path = [self logFilePath];
    NSString *contentsOfLogFile = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if (contentsOfLogFile != nil && ![contentsOfLogFile isEqualToString:@""]) {
        logs = [[[contentsOfLogFile split:LOG_ENTRY_SEPARATOR_CHAR] reverse] mutableCopy];
        [logs removeObject:@""];
    }
    return logs;
}

- (void)writeQueued {
    NSMutableArray *logsToWrite = [self.logQueue copy];
    [self.logQueue removeAllObjects];
    dispatch_async(GTCommandFileLogging(), ^{
        NSMutableString *result = [@"" mutableCopy];
        [logsToWrite each:^(NSString *logEntry) {
            [result appendString:[NSString stringWithFormat:@"%@%@", logEntry, LOG_ENTRY_SEPARATOR_CHAR]];
        }];
        
        NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];

        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self logFilePath]];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];
    });
}

- (NSString *)directoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    return [NSString stringWithFormat:@"%@/%@", documentsDirectory, LOG_DIRECTORY];
}

- (NSString *)logFilePath {
    return [NSString stringWithFormat:@"%@/%@", [self directoryPath], self.filename];
}
@end
