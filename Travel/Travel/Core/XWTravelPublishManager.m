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
    [user isAuthenticatedWithSessionToken:user.sessionToken callback:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [travelTogetherPrivate saveEventually:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [user.privateTravelData_TravelTogether addObject:travelTogetherPrivate];
                    [user saveEventually];
                }
                block(succeeded,error);
            }];
        }
        else {
            block(NO,error);
        }
    }];
}

+ (void)publishTravelTogether:(TravelTogetherPrivate *)travelTogether withBlock:(XWTravelTogetherPublishResultBlock)block {
    
    TravelTogether *object = [travelTogether convertToTravelTogetherData];
    
    XWCommend *commend = [[XWCommend alloc]init];
    
    [AVObject saveAllInBackground:@[object, commend] block:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            XWUser *user = [XWUser currentUser];
            [user.privateTravelData_TravelTogether removeObject:travelTogether];
            [travelTogether deleteInBackground];
            [user.publishedTravelData_TravelTogether addObject:object];
            [user saveEventually];
            
            commend.superData = object;
            [commend saveInBackground];
            object.commend = commend;
            [object saveInBackground];
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
                status.data= @{dataSource:@{__type:Pointer,className:NSStringFromClass([TravelTogether class]),objectId:travelTogether.objectId},
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
    AVQuery *query = [AVQuery queryWithClassName:_Status];
    [query orderByDescending:createdAt];
    query.limit = pageSize;
    [query includeKey:dataSource];
    [query includeKey:[@[dataSource,publisher] componentsJoinedByString:@"."]];
    [query includeKey:[@[dataSource,commend] componentsJoinedByString:@"."]];
    [query includeKey:[@[dataSource,commend,commendUserArr] componentsJoinedByString:@"."]];
    [query includeKey:source];
    if (minDataTimestamp) {
        [query whereKey:createdAt lessThanOrEqualTo:[NSDate dateWithTimeIntervalSince1970:minDataTimestamp]];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        SNServerAPIResultData *result = [[SNServerAPIResultData alloc]init];
        result.hasError = error;
        result.error = error;
        if (!result.hasError) {
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
