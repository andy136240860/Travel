//
//  XWTravelPublishManager.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/18.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVOSCloud.h"
#import "XWUser.h"
#import "Travel.h"
#import "SNServerAPIResultData.h"

typedef void (^XWTravelTogetherPublishResultBlock)(BOOL succeeded, NSError *error, TravelTogether *travelTogether);
typedef void (^XWServerResultBlock)(BOOL succeeded, NSError *error, id responseObject , id parsedModelObject);

typedef void (^XWServerAPIBlock)(id request,SNServerAPIResultData * result);

@interface XWTravelPublishManager : NSObject

+ (void)saveTravelTogetherPrivate:(TravelTogetherPrivate *)travelTogetherPrivate withBlock:(AVBooleanResultBlock)block;

+ (void)publishTravelTogether:(TravelTogether *)travelTogether withBlock:(XWTravelTogetherPublishResultBlock)block;

+ (void)sendStatusToFollowersWithData:(id)data context:(NSString *)context block:(AVBooleanResultBlock)block;

+ (void)getALLStatuswithPage:(NSUInteger)page pageSize:(NSUInteger)pageSize minDataTimestamp:(NSUInteger)minDataTimestamp block:(XWServerAPIBlock)block;

@end
