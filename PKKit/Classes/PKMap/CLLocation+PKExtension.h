//
//  CLLocation+PKExtension.h
//  Pods
//
//  Created by lawn.cao on 16/9/21.
//
//

#import <CoreLocation/CoreLocation.h>

/**
 *  火星坐标系：中国使用的坐标系
 *  地球坐标系：即WGS84，CoreLocation定位获取的就是这个坐标系坐标
 *  百度坐标系：百度自己的坐标系
 *
 */
@interface CLLocation (PKExtension)

/**
 *  WGS84转火星坐标
 *
 *  @return 火星坐标
 */
- (CLLocation *)pk_mars;

/**
 *  WGS84转百度坐标
 *
 *  @return ddddd
 */
- (CLLocation *)pk_baidu;

/**
 *  是否在中国区域外
 *
 *  @return 是否在中国区域外
 */
- (BOOL)pk_isOutOfChina;

@end
