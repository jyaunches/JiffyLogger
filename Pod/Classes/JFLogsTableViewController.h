//
//  JFLogsScreenViewController.h
//  JiffyLogger
//
//  Created by Julietta Yaunches on 9/11/15.
//  Copyright © 2015 jyaunches. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JFFileLogger;

@interface JFLogsTableViewController : UITableViewController

- (id)initWithLogger:(JFFileLogger *)logger;
@end
