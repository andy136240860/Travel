//
//  CUComment.h
//  EShiJia
//
//  Created by li na on 15/4/20.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWUser.h"

@class CUReply;

@interface CUComment : NSObject

@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *commentTimeStamp;
@property (nonatomic, strong) NSString *infoId;

@property (nonatomic, strong) XWUser *user;

@property (nonatomic, strong) NSMutableArray<CUReply *> *replyArray;

@property float rate;

@end

@interface CUReply : CUComment

@property (nonatomic, strong) NSString *toId;  // 暂时无用
@property (nonatomic, strong) XWUser *toUser;

- (NSString *)replyContentToComment:(CUComment *)comment;
- (NSMutableAttributedString *)replyAttrStringToComment:(CUComment *)comment;

- (NSString *)myReplyContent;
- (NSMutableAttributedString *)myReplyAttrString;

@end
