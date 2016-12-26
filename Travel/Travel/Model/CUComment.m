//
//  CUComment.m
//  EShiJia
//
//  Created by li na on 15/4/20.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import "CUComment.h"
#import "CUUserManager.h"

@implementation CUComment


- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (BOOL)isEqual:(CUComment *)object
{
    if (![object isKindOfClass:[CUComment class]]) {
        return NO;
    }
    
    if ([object.commentId isEqual:self.commentId] && [object.infoId isEqual:self.infoId]) {
        return YES;
    }
    
    return NO;
}

- (NSUInteger)hash
{
    return self.commentId.hash;
}

@end

@implementation CUReply

- (NSString *)replyContentToComment:(CUComment *)comment
{
    NSString *userNick = [self.user displayName];

    NSString *toUserNick = [self.toUser displayName];

    NSString *str = nil;
    if (self.toUser && ![self.toUser isEqualtoUser:comment.user]) {
        str = [NSString stringWithFormat:@"%@回复%@：%@", userNick, toUserNick, self.content];
    }
    else {
        str = [NSString stringWithFormat:@"%@：%@", userNick, self.content];
    }
    return str;
}

- (NSMutableAttributedString *)replyAttrStringToComment:(CUComment *)comment
{
    NSString *str = [self replyContentToComment:comment];
    
    NSString *userNick = [self.user displayName];
    
    NSString *toUserNick = [self.toUser displayName];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    [text addAttribute:NSForegroundColorAttributeName
                 value:kYellowColor
                 range:NSMakeRange(0, userNick.length)];
    
    if (self.toUser && ![self.toUser isEqualtoUser:comment.user]) {
        [text addAttribute:NSForegroundColorAttributeName
                     value:kYellowColor
                     range:NSMakeRange(userNick.length + 2, toUserNick.length)];
    }
    
    return text;
}

- (NSString *)myReplyContent
{
    NSString *str = nil;
    
    if ([self.toUser isEqualtoUser:[XWUser currentUser]]) {
        str = [NSString stringWithFormat:@"回复了您：%@", self.content];
    }
    else {
        NSString *toUserNick = [self.toUser displayName];
        
        str = [NSString stringWithFormat:@"在你的评论中回复了%@：%@", toUserNick, self.content];
    }
    
    return str;
}

- (NSMutableAttributedString *)myReplyAttrString
{
    NSString *str = [self myReplyContent];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:kBlackColor
                 range:NSMakeRange(0, str.length)];
    
    if (self.toUser && ![self.toUser isEqualtoUser:[XWUser currentUser]]) {
        NSString *toUserNick = [self.toUser displayName];
        
        if (str.length > 9 + toUserNick.length) {
            [text addAttribute:NSForegroundColorAttributeName
                         value:kYellowColor
                         range:NSMakeRange(9, toUserNick.length)];
        }
    }
    
    return text;
}

@end
