//
//  FieldTestLoggingActionManager.h
//  GoTenna
//
//  Created by Julietta Yaunches on 6/23/15.
//  Copyright (c) 2015 goTenna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JFLogExportProtocol.h"

@interface JFLoggingActionManager : NSObject<UIActionSheetDelegate>
- (id)initWithSource:(UIViewController *)source andLogger:(id <JFLogExportProtocol>)logger onTruncate:(void (^)())truncate;
- (void)show;
@end
