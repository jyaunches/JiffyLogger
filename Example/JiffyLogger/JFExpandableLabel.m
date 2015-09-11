//
//  JFExpandableLabel.m
//  JiffyLogger
//
//  Created by Julietta Yaunches on 9/11/15.
//  Copyright © 2015 jyaunches. All rights reserved.
//

#import "JFExpandableLabel.h"

@interface JFExpandableLabel ()
@property(nonatomic) CGSize maximumLabelSize;
@property(nonatomic) int const padding;
@end

@implementation JFExpandableLabel
- (void)updateWithText:(NSString *)content {
    self.text = content;
    CGSize newSize = [self sizeThatFits:self.maximumLabelSize];
    CGRect newFrame = CGRectMake(self.padding / 2, self.padding / 2, newSize.width, newSize.height);
    self.frame = newFrame;
}

- (id)initForLog:(NSString *)log {
    self = [self init];
    self.maximumLabelSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 999);
    self.font = [UIFont systemFontOfSize:12];
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.textAlignment = NSTextAlignmentLeft;
    self.textColor = [UIColor whiteColor];
    self.padding = 10;

    [self updateWithText:log];

    return self;
}

@end
