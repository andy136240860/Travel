//
//  XWCommentManager.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/25.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CUComment.h"
#import "XWTravelPublishManager.h"

@interface XWCommentManager : NSObject

+ (void)sendCommentWithObject:(AVObject *)object toComment:(CUComment *)comment content:(NSString *)contentText block:(XWServerAPIBlock)block;

+ (void)getCommentListWithObject:(AVObject *)object page:(NSInteger)page pageSize:(NSInteger)pageSize block:(XWServerAPIBlock)block pageName:(NSString *)pageName;
@end
