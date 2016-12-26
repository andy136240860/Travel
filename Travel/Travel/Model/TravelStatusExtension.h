//
//  TravelStatusExtension.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/5.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWUser.h"

typedef NS_ENUM(NSInteger, TravelDataType) {
    TravelDataTypePicture       = 1,    // 图片
    TravelDataTypeVideo         = 2,    // 视频
    TravelDataTravelTogether    = 3,    //一起旅行
};


@protocol TravelStatusExtension <NSObject>

@property (nonatomic, assign) TravelDataType   travelDataType;
@property (nonatomic, strong) XWUser    *publisher;
@property (nonatomic, strong) NSMutableArray *commendedUserArray;

@end
