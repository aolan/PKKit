//
//  NSDate+PKExtension.h
//  Pods
//
//  Created by lawn.cao on 16/9/21.
//  Copyright © 2016年 lawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PKExtension)

/**
 *  获取时间戳，单位毫秒
 *
 *  @return 时间戳，单位毫秒
 */
- (NSString *)pk_TimestampMs;

/**
 *  获取时间戳，单位秒
 *
 *  @return 时间戳，单位秒
 */
- (NSString *)pk_TimestampSec;


@end
