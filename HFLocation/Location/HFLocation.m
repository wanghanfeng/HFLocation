//
//  HFLocation.m
//  HFLocation
//
//  Created by whf on 17/6/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HFLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface HFLocation() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationMgr;
@property (nonatomic, copy) void (^block) (NSError *error,NSDictionary *result);

@end

@implementation HFLocation

- (instancetype)sharedInstance {
    static HFLocation *location = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[HFLocation alloc] init];
    });
    return location;
}

- (instancetype)init {
    if (self = [super init]) {
        CLLocationManager *locationMgr = [[CLLocationManager alloc] init];
        self.locationMgr = locationMgr;
        [locationMgr requestWhenInUseAuthorization];
        locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
        locationMgr.distanceFilter = 10.0;
        locationMgr.delegate = self;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@ -dealloc",NSStringFromClass([self class]));
}

- (void)getLocationName:(void (^)(NSError *, NSDictionary *))block {
    if ([CLLocationManager locationServicesEnabled]) {//定位服务开启
        [self.locationMgr startUpdatingLocation];
        self.block = block;
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (locations) {
        CLLocation *location = [locations firstObject];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@",error);
                if (self.block) {
                    self.block(error,nil);
                }
            }
            else {
                CLPlacemark *placemark = [placemarks firstObject];
                self.block(nil,placemark.addressDictionary);
            }
        }];
        [self.locationMgr stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%@",error);
}
@end
