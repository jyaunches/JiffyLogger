//
//  JFLogTableViewCell.m
//  JiffyLogger
//
//  Created by Julietta Yaunches on 9/11/15.
//  Copyright © 2015 jyaunches. All rights reserved.
//

#import "JFLogTableViewCell.h"
#import "JFExpandableLabel.h"

@interface JFLogTableViewCell ()
@property(nonatomic, strong) JFExpandableLabel *logLabel;
@end

@implementation JFLogTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor blackColor];
    return self;
}

- (void)setup:(NSString*)log{
    if(!self.logLabel){
        self.logLabel = [[JFExpandableLabel alloc] initForLog:log];
        [self addSubview:self.logLabel];
    } else{
        [self.logLabel updateWithText:log];
    }    
}
@end
