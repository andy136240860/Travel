//
//  TravelExtension.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/31.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XWComment;
@class XWCommend;

typedef NS_ENUM(NSInteger, TravelDataType) {
    TravelDataTypePicture       = 1,    // 图片
    TravelDataTypeVideo         = 2,    // 视频
    TravelDataTravelTogether    = 3,    //一起旅行
};


@protocol TravelExtension <NSObject>

@property (nonatomic, assign) TravelDataType    travelDataType;
@property (nonatomic, strong) XWUser            *publisher;
@property (nonatomic, strong) XWCommend         *commend;
@property (nonatomic, strong) XWComment         *comment;
@property (nonatomic, assign) NSInteger         commentNumber;

@property (nonatomic, assign) NSInteger         geoCountryRegion;
@property (nonatomic, assign) NSInteger         geoState;
@property (nonatomic, assign) NSInteger         geoCity;

@end
