//
//  XWUser.h
//  Travel
//
//  Created by 晓炜 郭 on 16/8/5.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "AVUser.h"
#import "AVObject+Subclass.h"

@interface XWUser : AVUser<AVSubclassing>

@property (nonatomic, strong) NSString *avatar;

+ (NSString *)parseClassName;

@end
