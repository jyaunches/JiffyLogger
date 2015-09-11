//
//  JFViewController.m
//  JiffyLogger
//
//  Created by jyaunches on 09/11/2015.
//  Copyright (c) 2015 jyaunches. All rights reserved.
//

#import "JFViewController.h"
#import "JFLogsTableViewController.h"

@interface JFViewController ()

@end

@implementation JFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)logEventClicked:(id)sender {
}

- (IBAction)viewLogsClicked:(id)sender {
    JFLogsTableViewController *logsScreen = [[JFLogsTableViewController alloc] init];

    [self.navigationController pushViewController:logsScreen animated:YES];
}
@end
