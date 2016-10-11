//
//  XWUser.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/9.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWUser.h"
#import "AVOSCloud.h"

@implementation XWUser

+ (instancetype)currentUser {
    static XWUser *myUser = nil;
    
    if (myUser == nil) {
        AVUser *user = [AVUser currentUser];
        
        myUser = [[XWUser alloc] init];
        myUser.email = user.email;
        myUser.password = user.password;
        

        myUser.avatar = nil;
    }
    
    return myUser;
}

@end
