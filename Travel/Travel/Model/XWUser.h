//
//  XWUser.h
//  Travel
//
//  Created by 晓炜 郭 on 16/8/5.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "AVUser.h"
#import "AVObject+Subclass.h"
#import "AVGeoPoint.h"

@interface XWUser : AVUser <AVSubclassing>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *mySpaceBackgroundImageURL;
@property (retain) AVGeoPoint *locationGeoPoint; //当前位置， 每次打开APP更新
@property (retain) AVRelation *locationRelation; //用来做筛选， 与locationString同步
@property (nonatomic, strong) NSString *locationString; //地理位置的String,与locationRelation同步
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) NSInteger gender;  // 0 is male , 1 is female
@property (nonatomic, assign) NSInteger birthday;
@property (nonatomic, strong) NSString *profession;  //职业

@property (nonatomic, strong) NSString *selfIntroduction; //自我介绍
@property (nonatomic, strong) NSString *signature; //个性签名

@property (retain) AVRelation *privateTravelData; //保存在自己账户的数据， 比如一起旅行，旅行详情等等
@property (retain) AVRelation *publishedTravelData; //保存在自己账户的数据， 比如一起旅行，旅行详情等等
+ (NSString *)parseClassName;

@end
