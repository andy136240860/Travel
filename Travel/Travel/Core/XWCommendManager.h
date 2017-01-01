//
//  XWCommendManager.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/31.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWTravelPublishManager.h"

@interface XWCommendManager : NSObject

+ (void)commendObject:(XWCommend *)commend block:(AVBooleanResultBlock)block;

+ (void)disCommendObject:(XWCommend *)commend block:(AVBooleanResultBlock)block;
@end
