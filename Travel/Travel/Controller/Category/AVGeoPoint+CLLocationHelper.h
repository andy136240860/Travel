//
//  AVGeoPoint+CLLocationHelper.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/3.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
#import <CoreLocation/CoreLocation.h>
typedef void(^CityNameBlock)(NSString *cityName);

@interface AVGeoPoint (CLLocationHelper)

- (void)getCityNameWithBlock:(CityNameBlock)block;

@end
