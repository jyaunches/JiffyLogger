//
//  DepInj.m
//  GoTenna
//
//  Created by Julietta Yaunches on 9/9/15.
//  Copyright (c) 2015 goTenna. All rights reserved.
//

#import "JFFileLogger+DependencyInjection.h"

@implementation JFFileLogger (DependencyInjection)
@dynamic logQueue;

- (id)initWithLogQueue:(NSMutableArray *)logQueue{
    self = [self init];
    self.logQueue = logQueue;
    return self;
}
@end
