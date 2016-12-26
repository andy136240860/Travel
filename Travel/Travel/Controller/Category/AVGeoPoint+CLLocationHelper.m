//
//  AVGeoPoint+CLLocationHelper.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/3.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "AVGeoPoint+CLLocationHelper.h"

@implementation AVGeoPoint (CLLocationHelper)

- (void)getCityNameWithBlock:(CityNameBlock)block {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:self.latitude longitude:self.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city = %@", city);
            block(city);
        }
        else {
            block(@"未知位置");
        }
    }];
}

@end
