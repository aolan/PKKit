//
//  PKDeviceInfo.h
//  Pods
//
//  Created by lawn.cao on 16/9/21.
//  Copyright © 2016年 lawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKDeviceInfo : NSObject

/**
 *  设备唯一标识
 *
 *  特性：每次生成的都不一样，需要用keychain保存起来
 *
 *  @return 设备唯一标识
 */
+ (NSString *)UUIDString;

/**
 *  供应商标识符
 *
 *  特性：如果一台设备安装了同一个公司的两个app，而bundleId又正好是以com.companyA开始，则获取到的标识是一样的。
 *
 *  @return 供应商标识符
 */
+ (NSString *)IDFVString;

/**
 *  广告标识符
 *
 *  特性：一台设备上所有App获取到的都是一样的
 *
 *  @return 广告标识符
 */
+ (NSString *)IDFAString;

/**
 *  系统名称
 *
 *  @return 系统名称
 */
+ (NSString *)osName;

/**
 *  系统版本号
 *
 *  @return 系统版本号
 */
+ (NSString *)osVersion;

/**
 *  设备类型
 *
 *  返回诸如iPhone5,2，可以去网上搜索查看对应iPhone几
 *
 *  @return 设备类型
 */
+ (NSString *)deviceType;


@end
