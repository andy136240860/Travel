//
//  XWTravelPublishManager.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/18.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTravelPublishManager.h"
#import "MBProgressHUD.h"

@implementation XWTravelPublishManager

+ (void)saveTravelTogetherPrivate:(TravelTogetherPrivate *)travelTogetherPrivate withBlock:(AVBooleanResultBlock)block {
    TravelTogetherPrivate *object = [TravelTogetherPrivate objectWithClassName:MainDataPrivateClassName];
    object.travelDataType = TravelDataTravelTogether;
    object.title = travelTogetherPrivate.title;
    object.destinatin = travelTogetherPrivate.destinatin;
    object.startTime = travelTogetherPrivate.startTime;
    object.endTime = travelTogetherPrivate.endTime;
    object.peopleNumber = travelTogetherPrivate.peopleNumber;
    object.peopleNumberCanExceed = travelTogetherPrivate.peopleNumberCanExceed;
    object.price = travelTogetherPrivate.price;
    object.priceType = travelTogetherPrivate.priceType;
    object.traffic = travelTogetherPrivate.traffic;
    object.language = travelTogetherPrivate.language;
    object.detail = travelTogetherPrivate.detail;
    XWUser *user = [XWUser currentUser];
    //    object.TravelTogetherCompanions = [object relationForKey:@"TravelTogetherCompanions"];
    [object.TravelTogetherCompanions addObject:user];
    //    object.TravelTogetherGuides = [object relationForKey:@"TravelTogetherGuides"];
    [object.TravelTogetherGuides addObject:user];
    

    if ([user isAuthenticated]) {
        [object saveEventually:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [user.privateTravelData addObject:object];
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
            [user.privateTravelData removeObject:travelTogether];
            [user.publishedTravelData addObject:object];
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

                status.data= @{@"dataSource":@{@"__type":@"Pointer",@"className":MainDataClassName,@"objectId":travelTogether.objectId},@"TravelDataType":@(TravelDataTravelTogether)};

                [AVStatus sendStatusToFollowers:status andCallback:^(BOOL succeeded, NSError *error) {
                    NSLog(@"============ Send %@", [status debugDescription]);
                }];
            }
        }];
    }
    if ([data isMemberOfClass:[TravelTogether class]]) {

    }
}

@end
