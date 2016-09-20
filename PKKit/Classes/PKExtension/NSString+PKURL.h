//
//  NSString+PKURL.h
//  Pods
//
//  Created by 曹蔚 on 16/9/20.
//
//

#import <Foundation/Foundation.h>

@interface NSString (PKURL)

/**
 *  返回NSURL对象
 *
 *  @return NSURL对象
 */
- (NSURL *)pk_URL;

/**
 *  采用UTF-8编码
 *
 *  @return 返回编码后的字符串
 */
- (NSString *)pk_URLEncode;

/**
 *  采用UTF-8解码
 *
 *  @return 返回解码后的字符串
 */
- (NSString *)pk_URLDecode;

/**
 *  指定编码方式进行URLEncode
 *
 *  @param encoding 编码类型
 *
 *  @return 返回编码后的字符串
 */
- (NSString *)pk_URLEncodeUsingEncoding:(NSStringEncoding)encoding;

/**
 *  指定编码方式进行URLDecode
 *
 *  @param encoding 编码类型
 *
 *  @return 返回解码后的字符串
 */
- (NSString *)pk_URLDecodeUsingEncoding:(NSStringEncoding)encoding;

@end
