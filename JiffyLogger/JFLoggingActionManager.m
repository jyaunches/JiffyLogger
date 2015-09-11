//
//  FieldTestLoggingActionManager.m
//  GoTenna
//
//  Created by Julietta Yaunches on 6/23/15.
//  Copyright (c) 2015 goTenna. All rights reserved.
//

#import "JFLoggingActionManager.h"
#import "JFEmailer.h"

@interface JFLoggingActionManager ()
@property(nonatomic, strong) UIViewController *source;
@property(nonatomic, strong) JFEmailer *emailer;
@property(nonatomic, weak) id<JFLogExportProtocol> logger;
@property(nonatomic, copy) void (^onTruncate)();
@end

@implementation JFLoggingActionManager

- (void)show {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];

    [sheet addButtonWithTitle:@"Export"];
    [sheet addButtonWithTitle:@"Delete"];

    [sheet addButtonWithTitle:@"Cancel"];
    sheet.cancelButtonIndex = sheet.numberOfButtons - 1;

    [sheet showInView:self.source.view];
}

- (id)initWithSource:(UIViewController *)source andLogger:(id <JFLogExportProtocol>)logger onTruncate:(void (^)())truncate {
    self = [super init];
    self.source = source;
    self.emailer = [[JFEmailer alloc] initWithSource:source];
    self.logger = logger;
    self.onTruncate = truncate;

    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger numberOfButtons = actionSheet.numberOfButtons;

    if (buttonIndex == numberOfButtons - 1) {
        /// cancel button, do nothing
    }
    else if (buttonIndex == numberOfButtons - 2) {
        [self.logger truncateLog];
        if(self.onTruncate){
            self.onTruncate();
        }
    }
    else if (buttonIndex == numberOfButtons - 3) {
        [self.logger writeQueued];
        [self.emailer emailWithDocAttachment:[self.logger directory]
                                     subject:[self.logger subject]
                                    fileName:[self.logger exportFilename]
                                    receiver:[self.logger logDestinationEmail]
                                 messageBody:[self.logger messageBody]];
    }

}
@end
