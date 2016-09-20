//
//  NSDate+PKExtension.m
//  Pods
//
//  Created by 曹蔚 on 16/9/20.
//
//

#import "NSDate+PKExtension.h"

@implementation NSDate (PKExtension)

- (NSString *)pk_TimestampMs{
    return [NSString stringWithFormat:@"%.0lf", self.timeIntervalSince1970 * 1000];
}

- (NSString *)pk_TimestampSec{
    return [NSString stringWithFormat:@"%.0lf", self.timeIntervalSince1970];
}

@end
