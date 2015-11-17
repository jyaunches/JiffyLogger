//
//  LogSpec.m
//  GoTenna
//
//  Created by Julietta Yaunches on 9/9/15.
//  Copyright (c) 2015 goTenna. All rights reserved.
//

#import <ObjectiveSugar/ObjectiveSugar.h>
#import "Kiwi.h"
#import <JiffyLogger/JFFileLogger.h>
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

            it(@"should limit entry to 10 string parameters", ^{
                [[theBlock(^{
                    [fileLogger log:@"%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@",
                                    @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11"];
                }) should] raise];
            });
        });
        
        describe(@"file creation/writing/truncating", ^{
            __block JFFileLogger *fileLogger;

            beforeAll(^{
                fileLogger = [[JFFileLogger alloc] initWithTimestamps:NO];
            });
            
            it(@"should write to log", ^{
                [fileLogger truncateLog];
                [fileLogger log:@"entry"];
                [fileLogger writeQueued];

                sleep(1); //required because writeQueue is asynchronous
                NSArray *entriesAfterWrite = [fileLogger latestLogs];
                [[@(entriesAfterWrite.count) should] equal:@(1)];
                [[entriesAfterWrite[0] should] equal:@"entry"];
            });

            it(@"should automatically write queued entries after 50", ^{
                [fileLogger truncateLog];
                [@(49) times:^{
                    [fileLogger log:@"entry"];
                }];

                sleep(1); //required because writeQueue is asynchronous
                NSArray *entriesAfterWrite = [fileLogger latestLogs];
                [[@(entriesAfterWrite.count) should] equal:@(0)];

                [fileLogger log:@"50th entry"];

                sleep(1); //required because writeQueue is asynchronous
                NSArray *entriesAfter50th = [fileLogger latestLogs];
                [[@(entriesAfter50th.count) should] equal:@(50)];

            });

            it(@"should create file on initialization", ^{
                NSFileManager *fileManager = [NSFileManager defaultManager];
                BOOL fileInFileSystem = [fileManager fileExistsAtPath:fileLogger.logFilePath isDirectory:nil];

                [[@(fileInFileSystem) should] beTrue];
            });

            it(@"should truncate file", ^{
                JFFileLogger *logger = [[JFFileLogger alloc] initWithTimestamps:NO];
                NSFileManager *fileManager = [NSFileManager defaultManager];

                BOOL fileInFileSystem = [fileManager fileExistsAtPath:logger.logFilePath isDirectory:nil];

                [[@(fileInFileSystem) should] beTrue];
            });
        });

    });

SPEC_END

