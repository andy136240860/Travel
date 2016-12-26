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

@implementation XWStatus
@end

@implementation TravelTogether

@dynamic travelDataType;
@dynamic publisher;
@dynamic coverImageURL;
@dynamic title;  //标题
@dynamic destination; //地区
@dynamic startTime; //开始时间
@dynamic endTime;  //结束时间
@dynamic peopleNumber; //人数
@dynamic peopleNumberCanExceed; //人数可超
@dynamic price;  //钱数
@dynamic priceType; //钱的单位（美元或者元XXXX）
@dynamic traffic;
@dynamic language; 
@dynamic TravelTogetherCompanions; //同伴ralation，为各个user,key:TravelTogetherCompanions
@dynamic TravelTogetherGuides;  //导游ralation，给各个user,key:TravelTogetherCompanionsGuides
@dynamic detail; //旅游详情的html字符串
@dynamic joinedPeopleNumber;
@dynamic commendedUserArray;

+ (NSString *)parseClassName {
    return NSStringFromClass([TravelTogether class]);
}

@end

@implementation TravelTogetherPrivate

- (TravelTogether *)convertToTravelTogetherData {
    TravelTogether *object = [TravelTogether objectWithClassName:NSStringFromClass([TravelTogether class])];
    object.travelDataType = TravelDataTravelTogether;
    object.title = self.title;
    object.destination = self.destination;
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
    return NSStringFromClass([TravelTogetherPrivate class]);
}

@end

@implementation XWComment

@dynamic superData;
@dynamic toUser;
@dynamic user;
@dynamic context;
@dynamic relayArr;
@dynamic baseComment;

+ (NSString *)parseClassName {
    return NSStringFromClass([XWComment class]);
}

@end

@implementation XWCommend

@dynamic superData;
//@dynamic commendUserArr;

+ (NSString *)parseClassName {
    return NSStringFromClass([XWCommend class]);
}

@end
