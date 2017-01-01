//
//  Travel.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/11.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "AVObject.h"
#import "XWUser.h"
#import "AVObject+Subclass.h"
#import "AVStatus.h"
#import "TravelExtension.h"

static NSString * const dataSource = @"dataSource";
static NSString * const __type = @"__type";
static NSString * const Pointer = @"Pointer";
static NSString * const className = @"className";
static NSString * const objectId = @"objectId";
static NSString * const source = @"source";
static NSString * const contentText = @"contentText";
static NSString * const commendUserArr = @"commendUserArr";
static NSString * const superData = @"superData";
static NSString * const publisher = @"publisher";
static NSString * const commend = @"commend";
static NSString * const _Status = @"_Status";
static NSString * const createdAt = @"createdAt";

@class Forward;
@class TravelBaseData;


@interface Forward : NSObject<NSCopying>

@property (nonatomic, strong) XWUser *user;
@property (nonatomic, strong) NSString *context;

@end

@interface XWStatus : NSObject

@property (nonatomic, assign) TravelDataType            travelDataType;
@property (nonatomic, strong) NSString                  *context; //文本
@property (nonatomic, strong) Forward                   *forward; //转发信息
@property (nonatomic, strong) NSArray<NSString *>       *tags; //String数组

@property (nonatomic, strong) id                        dataSource;
@property (nonatomic, strong) id                        comment;

@end

//@interface TravelBaseData : AVObject
//
//@property (nonatomic, assign) TravelDataType    travelDataType;
//@property (nonatomic, strong) XWUser            *publisher;
//@property (nonatomic, strong) XWCommend         *commend;
//@property (nonatomic, strong) XWComment         *comment;
//
//@end

@interface TravelTogether : AVObject<AVSubclassing,TravelExtension>

@property (nonatomic, strong) NSString      *coverImageURL;
@property (nonatomic, strong) NSString      *title;  //标题
@property (nonatomic, strong) AVGeoPoint    *destination; //地区
@property (nonatomic, assign) NSInteger     startTime; //开始时间
@property (nonatomic, assign) NSInteger     endTime;  //结束时间
@property (nonatomic, assign) NSInteger     peopleNumber; //人数
@property (nonatomic, assign) BOOL          peopleNumberCanExceed; //人数可超
@property (nonatomic, assign) NSInteger     price;  //钱数
@property (nonatomic, strong) NSString      *priceType; //钱的单位（美元或者元XXXX）
@property (nonatomic, assign) BOOL          traffic;
@property (nonatomic, assign) BOOL          language;
@property (nonatomic, strong) AVRelation    *TravelTogetherCompanions; //同伴ralation，为各个user,key:TravelTogetherCompanions
@property (nonatomic, strong) AVRelation    *TravelTogetherGuides;  //导游ralation，给各个user,key:TravelTogetherGuides
@property (nonatomic, strong) NSString      *detail; //旅游详情的html字符串
@property (nonatomic, assign) NSInteger     joinedPeopleNumber; //已参加人数,每次TravelTogetherCompanions发生改变时更新

@end

@interface TravelTogetherPrivate : TravelTogether<AVSubclassing>

- (TravelTogether *)convertToTravelTogetherData;

@end

@interface XWComment : AVObject <AVSubclassing>

@property (nonatomic, strong) AVObject          *superData;
@property (nonatomic, strong) NSString          *infoId;
@property (nonatomic, strong) AVObject          *toComment;
@property (nonatomic, strong) XWUser            *toUser;
@property (nonatomic, strong) XWUser            *user;
@property (nonatomic, strong) NSString          *context;
@property (nonatomic, strong) NSMutableArray    *relayArr;

@property (nonatomic, assign) BOOL              baseComment;

@end

@interface XWCommend : AVObject <AVSubclassing>

@property (nonatomic, strong) AVObject          *superData;
@property (nonatomic, strong) NSArray<XWUser *> *commendUserArr;

@end
