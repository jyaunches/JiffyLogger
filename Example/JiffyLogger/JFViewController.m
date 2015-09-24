//
//  JFViewController.m
//  JiffyLogger
//
//  Created by jyaunches on 09/11/2015.
//  Copyright (c) 2015 jyaunches. All rights reserved.
//

#import <JiffyLogger/JFLogExportProtocol.h>
#import "JFViewController.h"
#import "JFLogsTableViewController.h"
#import "JFFileLogger+DependencyInjection.h"
#import "JFCommunicationLogger.h"
#import <JiffyLogger/NSString+JFStrings.h>

@interface JFViewController ()

@property(nonatomic, strong) JFCommunicationLogger *logger;
@end

@implementation JFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.logger = [JFCommunicationLogger shared];
}

- (IBAction)logEventClicked:(id)sender {
    int randomLogLength = arc4random_uniform(200);
    NSString *string = [NSString randomStringWithLength:randomLogLength];
    [self.logger log:string];
}

- (IBAction)viewLogsClicked:(id)sender {
    JFLogsTableViewController *logsScreen = [[JFLogsTableViewController alloc] init];

    [self.navigationController pushViewController:logsScreen animated:YES];
}
@end
