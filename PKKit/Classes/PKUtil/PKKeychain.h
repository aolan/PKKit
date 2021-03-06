//
//  PKKeychain.h
//  Pods
//
//  Created by lawn.cao on 16/9/21.
//  Copyright © 2016年 lawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKKeychain : NSObject

/**
 *  保存对象到keychain
 *
 *  @param service 服务名称
 *  @param data    要存储的对象
 */
+ (void)save:(NSString *)service data:(id)data;

/**
 *  根据服务名称获取数据
 *
 *  @param service 服务名称
 *
 *  @return 返回存储的对象
 */
+ (id)loadData:(NSString *)service;

/**
 *  删除Keychain中数据
 *
 *  @param service 服务名称
 */
+ (void)deleteData:(NSString *)service;

@end
