//
// Created by Julietta Yaunches on 4/8/15.
// Copyright (c) 2015 goTenna. All rights reserved.
//

#import "JFEmailer.h"

@implementation JFEmailer

- (void)emailWithDocAttachment:(NSString *)filePath subject:(NSString *)subject fileName:(NSString *)filename receiver:(NSString *)receiver messageBody:(NSString *)messageBody {
    if (self.source) {
        self.mc = [[MFMailComposeViewController alloc] init];
        self.mc.mailComposeDelegate = self;
        [self.mc setSubject:subject];
        [self.mc setToRecipients:@[receiver]];

        [self.mc setMessageBody:messageBody isHTML:NO];

        NSData *data = [NSData dataWithContentsOfFile:filePath];
        [self.mc addAttachmentData:data mimeType:@"text/plain" fileName:filename];
        if (self.mc) {
            [self.source presentViewController:self.mc animated:YES completion:NULL];
        }
    }
}

- (id)initWithSource:(UIViewController *)source {
    self = [super init];
    self.source = source;
    return self;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }

    // Close the Mail Interface
    [self.source dismissViewControllerAnimated:YES completion:NULL];
}
@end