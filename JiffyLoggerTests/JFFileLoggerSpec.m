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
        it(@"should take format string and subsequent string arguments", ^{
            NSMutableArray *stubQueue = [NSMutableArray array];
            JFFileLogger *fileLogger = [[JFFileLogger alloc] initWithLogQueue:stubQueue];
            [fileLogger logThis:@"Hey there: %@, %@", @"foo", @"bar"];

            [[@([stubQueue count]) should] equal:@(1)];
            [[[stubQueue firstObject] should] equal:@"Hey there: foo, bar"];
        });

        it(@"should take just a string without arguments", ^{
            NSMutableArray *stubQueue = [NSMutableArray array];
            JFFileLogger *fileLogger = [[JFFileLogger alloc] initWithLogQueue:stubQueue];
            [fileLogger logThis:@"Hey there!"];

            [[@([stubQueue count]) should] equal:@(1)];
            [[[stubQueue firstObject] should] equal:@"Hey there!"];
        });
    });

SPEC_END

