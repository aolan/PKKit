//
//  CLLocation+PKExtension.m
//  Pods
//
//  Created by lawn.cao on 16/9/21.
//
//

#import "CLLocation+PKExtension.h"

const double a = 6378245.0;
const double ee = 0.00669342162296594323;
const double x_pi = M_PI * 3000.0 / 180.0;

@implementation CLLocation (PKExtension)

#pragma mark - Interface Methods

- (CLLocation *)pk_mars{
    
    if (self.pk_isOutOfChina) {
        return self;
    }
    
    double dLat = [self transformLatWithX:(self.coordinate.longitude - 105.0) y:(self.coordinate.latitude - 35.0)];
    double dLon = [self transformLonWithX:(self.coordinate.longitude - 105.0) y:(self.coordinate.latitude - 35.0)];
    double radLat = self.coordinate.latitude / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
    return [[CLLocation alloc] initWithLatitude:self.coordinate.latitude + dLat longitude:self.coordinate.longitude + dLon];
}

- (CLLocation *)pk_baidu{
    CLLocation *mars = self.pk_mars;
    return [self marsToBaidu:mars.coordinate.latitude mlon:mars.coordinate.longitude];
}


- (BOOL)pk_isOutOfChina{
    
    if (self.coordinate.longitude < 72.004 || self.coordinate.longitude > 137.8347) {
        return YES;
    }
    if (self.coordinate.latitude < 0.8293 || self.coordinate.latitude > 55.8271) {
        return YES;
    }
    return NO;
}

#pragma mark - Private Methods

- (double)transformLatWithX:(double)x y:(double)y {
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

- (double)transformLonWithX:(double)x y:(double)y {
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

- (CLLocation *)marsToBaidu:(double)mlat mlon:(double)mlon{
    double x = mlon, y = mlat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    double bd_lon = z * cos(theta) + 0.0065;
    double bd_lat = z * sin(theta) + 0.006;
    return [[CLLocation alloc] initWithLatitude:bd_lat longitude:bd_lon];
}


@end
