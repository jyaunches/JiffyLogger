//
//  JFLogTableViewCell.h
//  JiffyLogger
//
//  Created by Julietta Yaunches on 9/11/15.
//  Copyright © 2015 jyaunches. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JFExpandableLabel;

@interface JFLogTableViewCell : UITableViewCell

- (void)setup:(NSString*)log;
@end
