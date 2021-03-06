//
// Created by Julietta Yaunches on 4/8/15.
// Copyright (c) 2015 goTenna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JiffyLogger/JFFileLogger.h>
#import <JiffyLogger/JFLogExportProtocol.h>

@interface JFCommunicationLogger : JFFileLogger<JFLogExportProtocol>
+ (JFCommunicationLogger *)shared;
@end