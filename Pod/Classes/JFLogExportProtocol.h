//
//  JPLogExportProtocol.h
//  JiffyLogger
//
//  Created by Julietta Yaunches on 9/9/15.
//  Copyright (c) 2015 yaunches. All rights reserved.
//

@protocol JFLogExportProtocol <NSObject>
-(NSString *)directory;
-(NSString *)exportFilename;
-(NSString *)subject;

-(void)truncateLog;
-(void)writeQueued;

- (NSString *)logDestinationEmail;
- (NSString *)messageBody;
@end
