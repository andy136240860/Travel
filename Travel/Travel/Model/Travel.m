//
//  Travel.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/11.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "Travel.h"

@implementation Forward

- (id)copyWithZone:(nullable NSZone *)zone {
    Forward *forword = [[Forward alloc]init];
    forword.context = [self.context copy];
    return forword;
}

@end

//@implementation XWStatus
//
//+ (NSString *)parseClassName {
//    return @"_Status";
//}
//
//@end

@implementation TravelTogether

@dynamic travelDataType;
@dynamic publisher;
@dynamic headerViewBackgroundImageURL;
@dynamic title;  //标题
@dynamic destinatin; //地区
@dynamic startTime; //开始时间
@dynamic endTime;  //结束时间
@dynamic peopleNumber; //人数
@dynamic peopleNumberCanExceed; //人数可超
@dynamic price;  //钱数
@dynamic priceType; //钱的单位（美元或者元XXXX）
@dynamic traffic;
@dynamic language; //NSString，ISOLanguageCodes，有逗号分隔
@dynamic TravelTogetherCompanions; //同伴ralation，为各个user,key:TravelTogetherCompanions
@dynamic TravelTogetherGuides;  //导游ralation，给各个user,key:TravelTogetherCompanionsGuides
@dynamic detail; //旅游详情的html字符串

+ (NSString *)parseClassName {
    return MainDataClassName;
}

@end

@implementation TravelTogetherPrivate

- (TravelTogether *)convertToTravelTogetherData {
    TravelTogether *object = [TravelTogether objectWithClassName:MainDataClassName];
    object.travelDataType = TravelDataTravelTogether;
    object.title = self.title;
    object.destinatin = self.destinatin;
    object.startTime = self.startTime;
    object.endTime = self.endTime;
    object.peopleNumber = self.peopleNumber;
    object.peopleNumberCanExceed = self.peopleNumberCanExceed;
    object.price = self.price;
    object.priceType = self.priceType;
    object.traffic = self.traffic;
    object.language = self.language;
    object.detail = self.detail;
    object.TravelTogetherCompanions = self.TravelTogetherCompanions;
    object.TravelTogetherGuides = self.TravelTogetherGuides;
    
    return object;
}

+ (NSString *)parseClassName {
    return MainDataPrivateClassName;
}

@end
