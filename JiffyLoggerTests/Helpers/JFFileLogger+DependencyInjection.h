//
//  DepInj.h
//  GoTenna
//
//  Created by Julietta Yaunches on 9/9/15.
//  Copyright (c) 2015 goTenna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFFileLogger.h"

@interface JFFileLogger (DependencyInjection)
@property(nonatomic, strong) NSMutableArray *logQueue;

- (id)initWithLogQueue:(NSMutableArray *)logQueue;

@end
