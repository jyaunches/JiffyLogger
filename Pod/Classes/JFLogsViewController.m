//
//  JFLogsScreenViewController.m
//  JiffyLogger
//
//  Created by Julietta Yaunches on 9/11/15.
//  Copyright © 2015 jyaunches. All rights reserved.
//

#import <JiffyLogger/JFLoggingActionManager.h>
#import "JFLogsViewController.h"
#import "JFFileLogger.h"
#import "NSArray+ObjectiveSugar.h"
#import "NSNumber+ObjectiveSugar.h"

@interface JFLogsViewController ()
@property(nonatomic, strong) JFFileLogger<JFLogExportProtocol> *logger;
@property(nonatomic, strong) id actionSheetManager;
@end

@implementation JFLogsViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.logger writeQueued];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(action)];

    CGRect frame = self.view.frame;
    self.textScrollView = [[UITextView alloc] initWithFrame:frame];
    self.textScrollView.backgroundColor = [UIColor clearColor];
    self.textScrollView.textColor = [UIColor whiteColor];

    [self.view addSubview:self.textScrollView];
    CGFloat frameWidth = self.view.frame.size.width;

    NSMutableString *divider = [@"" mutableCopy];
    [@(frameWidth/41) times:^{
        [divider appendString:@"----------"];
    }];
    NSString *logContent = [[self.logger allLogs] join:[NSString stringWithFormat:@"\n%@\n", divider]];

    self.textScrollView.text = logContent;
    
}

- (id)initWithLogger:(JFFileLogger <JFLogExportProtocol> *)logger {
    self = [super init];
    self.logger = logger;
    [self.logger writeQueued];
    return self;
}

- (void)action {
    self.actionSheetManager = [[JFLoggingActionManager alloc] initWithSource:self andLogger:self.logger onTruncate:^(){
        [self reloadData];
    }];
    [self.actionSheetManager show];
}

- (void)reloadData {
    [self.logger writeQueued];
    self.textScrollView = [[UITextView alloc] initWithFrame:self.view.frame];
    self.textScrollView.text = [[self.logger allLogs] join:@"\n"];
}

@end
