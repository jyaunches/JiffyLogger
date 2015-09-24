//
//  NSString+JFStrings.m
//  Pods
//
//  Created by Julietta Yaunches on 9/24/15.
//
//

#import "NSString+JFStrings.h"

@implementation NSString (JFStrings)
NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}
@end
