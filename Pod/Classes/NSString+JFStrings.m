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

- (NSString *)substituteArguments:(NSMutableArray *)theArgs {
    NSString *result;
    if(theArgs.count > 0){
        if (theArgs.count > 10 ) {
            @throw [NSException exceptionWithName:NSRangeException reason:@"Maximum of 10 arguments allowed" userInfo:@{@"collection": theArgs}];
        }
        NSArray* a = [theArgs arrayByAddingObjectsFromArray:@[@"X",@"X",@"X",@"X",@"X",@"X",@"X",@"X",@"X",@"X"]];
        result = [NSString stringWithFormat:self, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10] ];
    }else{
        result = self;
    }

    return result;
}
@end
