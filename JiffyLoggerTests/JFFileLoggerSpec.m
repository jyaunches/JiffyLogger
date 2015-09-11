//
//  LogSpec.m
//  GoTenna
//
//  Created by Julietta Yaunches on 9/9/15.
//  Copyright (c) 2015 goTenna. All rights reserved.
//

#import <ObjectiveSugar/ObjectiveSugar.h>
#import "Kiwi.h"
#import "JFFileLogger.h"
#import "JFFileLogger+DependencyInjection.h"

SPEC_BEGIN(JFFileLoggerSpec)
    describe(@"JFFileLogger", ^{
        describe(@"log entry formatting", ^{
            __block NSMutableArray *stubQueue;
            __block JFFileLogger *fileLogger;

            beforeEach(^{
                stubQueue = [NSMutableArray array];
                fileLogger = [[JFFileLogger alloc] initWithLogQueue:stubQueue];
            });

            it(@"should take format string and subsequent string arguments", ^{
                [fileLogger log:@"Hey there: %@, %@", @"foo", @"bar"];

                [[@([stubQueue count]) should] equal:@(1)];
                [[[stubQueue firstObject] should] equal:@"Hey there: foo, bar"];
            });

            it(@"should take just a string without arguments", ^{
                [fileLogger log:@"Hey there!"];

                [[@([stubQueue count]) should] equal:@(1)];
                [[[stubQueue firstObject] should] equal:@"Hey there!"];
            });
        });
        
        describe(@"writing to file", ^{
            it(@"should create file on initialization", ^{
                JFFileLogger *logger = [[JFFileLogger alloc] initWithFileName:@"test-file.txt" andSeparator:@"\n" withTimestamps:NO];
                NSFileManager *fileManager = [NSFileManager defaultManager];

                BOOL fileInFileSystem = [fileManager fileExistsAtPath:logger.logFilePath isDirectory:nil];

                [[@(fileInFileSystem) should] beTrue];
            });    
        });

    });

SPEC_END

