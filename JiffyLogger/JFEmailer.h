//
// Created by Julietta Yaunches on 4/8/15.
// Copyright (c) 2015 goTenna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface JFEmailer : NSObject <MFMailComposeViewControllerDelegate>
@property(nonatomic, strong) UIViewController *source;
@property(nonatomic, strong) MFMailComposeViewController *mc;

- (void)emailWithDocAttachment:(NSString *)location subject:(NSString *)subject fileName:(NSString *)filename receiver:(NSString *)receiver messageBody:(NSString *)messageBody;

- (id)initWithSource:(UIViewController *)source;
@end