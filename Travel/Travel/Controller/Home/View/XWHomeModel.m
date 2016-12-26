//
//  XWHomeModel.m
//  Demo
//
//  Created by 格式化油条 on 15/7/7.
//  Copyright (c) 2015年 格式化油条. All rights reserved.
//

#import "XWHomeModel.h"


@implementation XWHomeModel

+ (instancetype)feedWithDictionary:(NSDictionary *)dictionary {

    return [[self alloc] initWithDictionary:dictionary];
}

-(NSMutableArray *)commentModelArray{
    if (_commentModelArray==nil) {
        _commentModelArray = [NSMutableArray array];
    }
    return _commentModelArray;
}

- (instancetype)initWithDictionary:(NSDictionary *) dictionary {
    
    if (self = [super init]) {
        self.homeCellType = 0;
        self.avatarURL = @"http://static.googleadsserving.cn/pagead/imgad?id=CICAgKDLxM_tmwEQrAIY-gEyCJ4f3nX5Lepz";
        self.username = dictionary[@"username"];
        self.timeInterval = 1468826426;
        self.title = dictionary[@"content"];
        
        self.contentImageURLArray = @[@"http://static.googleadsserving.cn/pagead/imgad?id=CICAgKDLxM_tmwEQrAIY-gEyCJ4f3nX5Lepz",@"http://static.googleadsserving.cn/pagead/imgad?id=CICAgKDLxM_tmwEQrAIY-gEyCJ4f3nX5Lepz",@"http://static.googleadsserving.cn/pagead/imgad?id=CICAgKDLxM_tmwEQrAIY-gEyCJ4f3nX5Lepz",@"http://static.googleadsserving.cn/pagead/imgad?id=CICAgKDLxM_tmwEQrAIY-gEyCJ4f3nX5Lepz"];
        
        self.contentVideoImageHolderURL = @"http://img.wdjimg.com/image/video/cd47d8370569dbb9b223942674c41785_0_0.jpeg";
        self.contentVideoURL = @"http://baobab.wdjcdn.com/1457521866561_5888_854x480.mp4";
        self.commendNumber = 8;
        self.commentNumber = 5;
        self.relayNumber   = 3;
        
        CommentModel *commentModel = [[CommentModel alloc] initWithDic:[NSDictionary  dictionary]];
        [self.commentModelArray addObject:commentModel];
    }
    return self;
}

@end
