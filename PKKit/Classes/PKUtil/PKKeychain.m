//
//  PKKeychain.m
//  Pods
//
//  Created by 曹蔚 on 16/9/20.
//
//

#import "PKKeychain.h"


@implementation PKKeychain

#pragma mark - Interface Methods

+ (void)save:(NSString *)service data:(id)data{
    // Get search dictionary
    NSMutableDictionary *keychainQuery = [[self getKeychainQuery:service] mutableCopy];
    // Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    // Translate id type to NSData type
    NSData *archiverData = [NSKeyedArchiver archivedDataWithRootObject:data];
    // Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:archiverData forKey:(__bridge_transfer id)kSecValueData];
    // Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+ (id)loadData:(NSString *)service{
    
    // Configure the search setting
    NSMutableDictionary *keychainQuery = [[self getKeychainQuery:service] mutableCopy];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    id ret = nil;

    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *) & keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed: %@", service, exception);
        } @finally {
            // do nothing
        }
    }
    return ret;
}

+ (void)deleteData:(NSString *)service {
    NSDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

#pragma mark - Help Methods

+ (NSDictionary *)getKeychainQuery:(NSString *)service {
    
    return @{
             (__bridge_transfer id)kSecClass: (__bridge_transfer id)kSecClassGenericPassword,
             (__bridge_transfer id)kSecAttrService: service,
             (__bridge_transfer id)kSecAttrAccount: service,
             (__bridge_transfer id)kSecAttrAccessible: (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock
             };
}


@end
