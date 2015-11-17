//
// Created by Julietta Yaunches on 4/8/15.
// Copyright (c) 2015 goTenna. All rights reserved.
//

#import "JFCommunicationLogger.h"

@implementation JFCommunicationLogger
+ (JFCommunicationLogger *)shared {
    static JFCommunicationLogger *logger = nil;
    if (!logger) {
        logger = [[JFCommunicationLogger alloc] initWithTimestamps:YES];
    }

    return logger;
}

- (NSString *)exportFilename {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM-dd-HHmmss"];
    NSString *string = [formatter stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%@-bt-logs.txt",string];
}

- (NSString *)subject {
    return @"iOS App - BT Log Report";
}

- (NSString *)logDestinationEmail {
    return @"jmyaunch@gmail.com";
}

- (NSString *)messageBody {
    return @"Email message content.";
}

@end