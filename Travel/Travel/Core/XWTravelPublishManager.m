//
//  XWTravelPublishManager.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/18.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTravelPublishManager.h"
#import "MBProgressHUD.h"
#import "XWBaseListModel.h"

@implementation XWTravelPublishManager

+ (void)saveTravelTogetherPrivate:(TravelTogetherPrivate *)travelTogetherPrivate withBlock:(AVBooleanResultBlock)block {
    XWUser *user = [XWUser currentUser];;
    [travelTogetherPrivate.TravelTogetherCompanions addObject:user];
    [travelTogetherPrivate.TravelTogetherGuides addObject:user];
    

    if ([user isAuthenticated]) {
        [travelTogetherPrivate saveEventually:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [user.privateTravelData_TravelTogether addObject:travelTogetherPrivate];
                [user saveEventually];
            }
            block(succeeded,error);
        }];
    }
    else {
        block(NO,[NSError errorWithDomain:@"用户登陆过期" code:-1 userInfo:nil]);
    }
}

+ (void)publishTravelTogether:(TravelTogetherPrivate *)travelTogether withBlock:(XWTravelTogetherPublishResultBlock)block {
    
    TravelTogether *object = [travelTogether convertToTravelTogetherData];

    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            XWUser *user = [XWUser currentUser];
            [user.privateTravelData_TravelTogether removeObject:travelTogether];
            [travelTogether deleteInBackground];
            [user.publishedTravelData_TravelTogether addObject:object];
            [user saveEventually];
        }
        block(succeeded,error,object);
    }];
}

+ (void)sendStatusToFollowersWithData:(id)data context:(NSString *)context block:(AVBooleanResultBlock)block{
    if ([data isMemberOfClass:[TravelTogetherPrivate class]]) {
        TravelTogetherPrivate *travelTogetherPrivate = (TravelTogetherPrivate *)data;
        [[self class] publishTravelTogether:travelTogetherPrivate withBlock:^(BOOL succeeded, NSError *error, TravelTogether *travelTogether) {
            if (succeeded) {
                AVStatus *status=[[AVStatus alloc] init];
                status.data= @{dataSourceTravelTogether:@{__type:Pointer,className:NSStringFromClass([TravelTogether class]),objectId:travelTogether.objectId},
                               @"TravelDataType":@(TravelDataTravelTogether),
                                   contentText:context
                               };

                [AVStatus sendStatusToFollowers:status andCallback:^(BOOL succeeded, NSError *error) {
                    NSLog(@"============ Send %@", [status debugDescription]);
                }];
            }
        }];
    }
    if ([data isMemberOfClass:[TravelTogether class]]) {

    }
}

+ (void)getALLStatuswithPage:(NSUInteger)page pageSize:(NSUInteger)pageSize minDataTimestamp:(NSUInteger)minDataTimestamp block:(XWServerAPIBlock)block {
    AVQuery *query = [AVQuery queryWithClassName:@"_Status"];
    [query orderByDescending:@"createdAt"];
    query.limit = pageSize;
    [query includeKey:dataSourceTravelTogether];
    [query includeKey:@"dataSourceTravelTogether.publisher"];
    [query includeKey:source];
    if (minDataTimestamp) {
        [query whereKey:@"createdAt" lessThanOrEqualTo:[NSDate dateWithTimeIntervalSince1970:minDataTimestamp]];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        SNServerAPIResultData *result = [[SNServerAPIResultData alloc]init];
        result.hasError = error;
        result.error = error;
        if (!result.hasError) {
//            for (AVObject *object in objects) {
//                TravelDataType travelDataType = [[object objectForKey:@"TravelDataType"] integerValue];
//                AVRelation *commendedUser = [object objectForKey:@"commendedUser"];
//                TravelTogether
//                if (travelDataType == TravelDataTravelTogether) {
//                    AVQuery *query = [[AVQuery alloc]initWithClassName:NSStringFromClass([TravelTogether class])];
//                    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//                        for (objects; <#condition#>; <#increment#>) {
//                            <#statements#>
//                        }
//                    }]
//                }
//                
//                
//            }

            XWBaseListModel *list = [[XWBaseListModel alloc]init];
            list.items = [NSMutableArray arrayWithArray:objects];
            result.responseAVObjects = objects;
            result.parsedModelObject = list;
            block(nil,result);
        }
        else {
            block(nil,result);
        }
    }];
}

@end
