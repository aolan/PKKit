//
//  NSString+PKURL.m
//  Pods
//
//  Created by lawn.cao on 16/9/21.
//  Copyright © 2016年 lawn. All rights reserved.
//

#import "NSString+PKURL.h"

@implementation NSString (PKURL)

- (NSURL *)pk_URL{
    return [NSURL URLWithString:self];
}

- (NSString *)pk_URLEncode{
    
    return [self pk_URLEncodeUsingEncoding:NSUTF8StringEncoding];
    
}

- (NSString *)pk_URLDecode{
    return [self pk_URLDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)pk_URLEncodeUsingEncoding:(NSStringEncoding)encoding{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}


- (NSString *)pk_URLDecodeUsingEncoding:(NSStringEncoding)encoding{
    
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}


@end
