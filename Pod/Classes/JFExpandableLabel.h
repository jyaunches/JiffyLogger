//
//  JFExpandableLabel.h
//  JiffyLogger
//
//  Created by Julietta Yaunches on 9/11/15.
//  Copyright © 2015 jyaunches. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFExpandableLabel : UILabel

- (id)initForLog:(NSString *)log;
- (void)updateWithText:(NSString *)content;
@end
