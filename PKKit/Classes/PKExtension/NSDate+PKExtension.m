//
//  NSDate+PKExtension.m
//  Pods
//
//  Created by lawn.cao on 16/9/21.
//  Copyright © 2016年 lawn. All rights reserved.
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
