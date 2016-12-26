//
//  XWUser.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/5.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWUser.h"

@implementation XWUser
@dynamic avatarURL;
@dynamic nickName;
@dynamic mySpaceBackgroundImageURL;
@dynamic locationGeoPoint; //当前位置， 每次打开APP更新
@dynamic locationRelation; //用来做筛选， 与locationString同步
@dynamic locationString; //地理位置的String,与locationRelation同步
@dynamic realName;
@dynamic gender;  // 0 is male , 1 is female
@dynamic birthday;
@dynamic profession;  //职业
@dynamic selfIntroduction; //自我介绍
@dynamic signature; //个性签名
@dynamic privateTravelData_TravelTogether;
@dynamic publishedTravelData_TravelTogether;


- (NSString *)displayName {
    return self.nickName.length == 0? self.username:self.nickName;
}


+ (NSString *)parseClassName {
    return @"_User";
}

- (BOOL)isEqualtoUser:(XWUser *)user {
    if ([user isKindOfClass:[XWUser class]] && [self isKindOfClass:[XWUser class]]) {
        if ([self.objectId isEqualToString:user.objectId] && self.objectId.length > 0) {
            return YES;
        }
        else {
            return NO;
        }
    }
    else return NO;
}

//+ (void)logInWithUsernameInBackground:(NSString *)username
//                             password:(NSString *)password
//                                block:(AVUserResultBlock)block {
//    [super logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
//        XWUser *myUser = [XWUser currentUser];
//        myUser.avatar = [user objectForKey:@"avatar"];
//        myUser.nickName = [user objectForKey:@"nickName"];
//        block(myUser,error);
//    }];
//}


@end
