//
//  XQFeedModel.m
//  Demo
//
//  Created by 格式化油条 on 15/7/7.
//  Copyright (c) 2015年 格式化油条. All rights reserved.
//

#import "XQFeedModel.h"

@implementation XQFeedModel

+ (instancetype)feedWithDictionary:(NSDictionary *)dictionary {

    return [[self alloc] initWithDictionary:dictionary];
}


- (instancetype) initWithDictionary:(NSDictionary *) dictionary {
    
    if (self = [super init]) {
        self.homeCellType = 0;
        self.avatarURL = @"http://static.googleadsserving.cn/pagead/imgad?id=CICAgKDLxM_tmwEQrAIY-gEyCJ4f3nX5Lepz";
        self.username = dictionary[@"username"];
        self.timeInterval = @"1468826426";
        self.title = dictionary[@"content"];
        self.contentImageURLArray = @[@"http://static.googleadsserving.cn/pagead/imgad?id=CICAgKDLxM_tmwEQrAIY-gEyCJ4f3nX5Lepz",@"http://static.googleadsserving.cn/pagead/imgad?id=CICAgKDLxM_tmwEQrAIY-gEyCJ4f3nX5Lepz",@"http://static.googleadsserving.cn/pagead/imgad?id=CICAgKDLxM_tmwEQrAIY-gEyCJ4f3nX5Lepz",@"http://static.googleadsserving.cn/pagead/imgad?id=CICAgKDLxM_tmwEQrAIY-gEyCJ4f3nX5Lepz"];
        self.contentVideoURL = nil;
        self.commendNumber = 8;
        self.commentNumber = 5;
        self.relayNumber   = 3;
    }
    return self;
}

@end
