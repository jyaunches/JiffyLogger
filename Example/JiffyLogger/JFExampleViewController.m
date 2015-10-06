//
//  JFViewController.m
//  JiffyLogger
//
//  Created by jyaunches on 09/11/2015.
//  Copyright (c) 2015 jyaunches. All rights reserved.
//

#import <JiffyLogger/JFLogExportProtocol.h>
#import <JiffyLogger/NSString+JFStrings.h>
#import <JiffyLogger/JFLogsViewController.h>
#import <ObjectiveSugar/ObjectiveSugar.h>
#import "JFExampleViewController.h"
#import "JFFileLogger+DependencyInjection.h"
#import "JFCommunicationLogger.h"

@interface JFExampleViewController ()
@property(nonatomic, strong) JFCommunicationLogger *logger;
@end

@implementation JFExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.logger = [JFCommunicationLogger shared];
}

- (IBAction)logEventClicked:(id)sender {
    [@(100) times:^{
        int randomLogLength = arc4random_uniform(200);
        NSString *string = [NSString randomStringWithLength:randomLogLength];
        [self.logger log:string];
    }];
}

- (IBAction)viewLogsClicked:(id)sender {
    JFLogsViewController *logsScreen = [[JFLogsViewController alloc] initWithLogger:self.logger];
    [self.navigationController pushViewController:logsScreen animated:YES];
}
@end
