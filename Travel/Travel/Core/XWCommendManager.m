//
//  XWCommendManager.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/31.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWCommendManager.h"

@implementation XWCommendManager

+ (void)commendObject:(XWCommend *)commend block:(AVBooleanResultBlock)block {
    NSArray *array = @[[XWUser currentUser]];
    [AVObject saveAllInBackground:array block:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [commend addObjectsFromArray:array forKey:commendUserArr];
            [commend saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                block(succeeded,error);
            }];
        }
        else {
            block(succeeded,error);
        }
    }];
}

+ (void)disCommendObject:(XWCommend *)commend block:(AVBooleanResultBlock)block {
    NSArray *array = @[[XWUser currentUser]];
    [commend removeObjectsInArray:array forKey:commendUserArr];
    
    [commend saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        block(succeeded,error);
    }];
}

@end
