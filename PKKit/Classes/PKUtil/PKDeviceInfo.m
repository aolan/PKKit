//
//  PKDeviceInfo.m
//  Pods
//
//  Created by 曹蔚 on 16/9/20.
//
//

#import "PKDeviceInfo.h"
#import "sys/utsname.h"
#import "PKKeychain.h"

static NSString *const kPKDeviceInfo_Service = @"com.pentakill.deviceinfo";
static NSString *const kPKDeviceInfo_UUID = @"com.pentakill.deviceinfo.uuid";
static NSString *const kPKDeviceInfo_IDFV = @"com.pentakill.deviceinfo.idfv";
static NSString *const kPKDeviceInfo_IDFA = @"com.pentakill.deviceinfo.idfa";


@implementation PKDeviceInfo

+ (NSString *)UUIDString{
    
    NSString *UUID = nil;
    NSMutableDictionary *dict = [[PKKeychain loadData:kPKDeviceInfo_Service] mutableCopy];
    if (dict) {
        UUID = [dict objectForKey:kPKDeviceInfo_UUID];
    }else{
        dict = [[NSMutableDictionary alloc] init];
    }
    
    if (!UUID) {
        UUID = [[NSUUID UUID] UUIDString];
        [dict setObject:UUID forKey:kPKDeviceInfo_UUID];
        [PKKeychain save:kPKDeviceInfo_Service data:dict];
    }
    return UUID;
}

+ (NSString *)IDFVString{
    
    NSString *IDFV = nil;
    NSMutableDictionary *dict = [[PKKeychain loadData:kPKDeviceInfo_Service] mutableCopy];
    if (dict) {
        IDFV = [dict objectForKey:kPKDeviceInfo_IDFV];
    }else{
        dict = [[NSMutableDictionary alloc] init];
    }
    
    if (!IDFV) {
        IDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [dict setObject:IDFV forKey:kPKDeviceInfo_IDFV];
        [PKKeychain save:kPKDeviceInfo_Service data:dict];
    }
    return IDFV;
}

+ (NSString *)IDFAString{
    
    NSString *IDFA = nil;
    NSMutableDictionary *dict = [[PKKeychain loadData:kPKDeviceInfo_Service] mutableCopy];
    if (dict) {
        IDFA = [dict objectForKey:kPKDeviceInfo_IDFA];
    }else{
        dict = [[NSMutableDictionary alloc] init];
    }
    
    if (!IDFA) {
        IDFA = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [dict setObject:IDFA forKey:kPKDeviceInfo_IDFA];
        [PKKeychain save:kPKDeviceInfo_Service data:dict];
    }
    return IDFA;
}


+ (NSString *)osName{
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)osVersion{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)deviceType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    platform = [platform stringByReplacingOccurrencesOfString:@"," withString:@"_"];
    return platform;
}


@end
