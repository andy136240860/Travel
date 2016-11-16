//
//  Travel.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/11.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "AVObject.h"
#import "XWUser.h"

@class Forward;
@class TravelBaseData;

typedef NS_ENUM(NSInteger, TravelDataType) {
    TravelDataTypePicture       = 1,    // 图片
    TravelDataTypeVideo         = 2,    // 视频
    TravelDataTravelTogether    = 3,    //一起旅行
};

@interface Forward : NSObject<NSCopying>

@property (nonatomic, strong) XWUser *user;
@property (nonatomic, strong) NSString *context;

@end

@interface TravelBaseData : AVObject

@property (nonatomic, assign) TravelDataType            typeId;
@property (nonatomic, strong) XWUser                    *user;
@property (nonatomic, strong) NSString                  *context; //文本
@property (nonatomic, strong) Forward                   *forward; //转发信息
@property (nonatomic, strong) NSArray<NSString *>       *tags; //String数组

@end

@interface TravelPicture : TravelBaseData

@property (nonatomic, strong) NSArray *picArr; //[string],picURL的数组

@end

@interface TravelVideo : TravelBaseData

@property (nonatomic, strong) NSString *videoURL;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString *videoImageURL;

@end

@interface TravelTogether : TravelBaseData

@property (nonatomic, strong) XWUser    *publisher;
@property (nonatomic, strong) NSString  *headerViewBackgroundImageURL;
@property (nonatomic, strong) NSString  *title;  //标题
@property (nonatomic, strong) NSString  *destinatin; //地区
@property (nonatomic, assign) NSInteger startTime; //开始时间
@property (nonatomic, assign) NSInteger endTime;  //结束时间
@property (nonatomic, assign) NSInteger peopleNumber; //人数
@property (nonatomic, assign) BOOL      peopleNumberCanExceed; //人数可超
@property (nonatomic, assign) NSInteger price;  //钱数
@property (nonatomic, strong) NSString  *priceType; //钱的单位（美元或者元XXXX）
@property (nonatomic, strong) NSString  *traffic;
@property (nonatomic, strong) NSString  *language; //NSString，ISOLanguageCodes，有逗号分隔
@property (nonatomic, strong) AVRelation   *TravelTogetherCompanions; //同伴ralation，为各个user,key:TravelTogetherCompanions
@property (nonatomic, strong) AVRelation   *TravelTogetherGuides;  //导游ralation，给各个user,key:TravelTogetherCompanionsGuides

@property (nonatomic, strong) NSString  *detail; //旅游详情的html字符串

@end
