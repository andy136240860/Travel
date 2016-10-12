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
    TravelDataTypePicture   = 1, // 图片
    TravelDataTypeVideo     = 2, // 视频
};

@interface Forward : NSObject

@property (nonatomic, assign) XWUser *user;
@property (nonatomic, assign) NSString *context;

@end

@interface TravelBaseData : AVObject

@property (nonatomic, assign) TravelDataType *typeId;
@property (nonatomic, strong) XWUser   *user;
@property (nonatomic, strong) NSString *context; //文本
@property (nonatomic, strong) Forward  *forward; //转发信息
@property (nonatomic, strong) NSArray  *tags; //String数组

@end

@interface TravelPicture : TravelBaseData

@property (nonatomic, strong) NSArray *picArr; //[string],picURL的数组

@end

@interface TravelVideo : TravelBaseData

@property (nonatomic, strong) NSString *videoURL;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString *videoImageURL;

@end
