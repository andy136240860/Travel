//
//  XQFeedModel.h
//  Demo
//
//  Created by 格式化油条 on 15/7/7.
//  Copyright (c) 2015年 格式化油条. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HomeCellType) {
    HomeCellTypeImage  = 0,
    HomeCellTypeVideo  = 1,
    HomeCellTypeImageText = 2,
};

@interface XQFeedModel : NSObject

@property                   HomeCellType    homeCellType;
@property (copy, nonatomic) NSString        *avatarURL;    //头像地址
@property (copy, nonatomic) NSString        *username;     //头像名称
@property (copy, nonatomic) NSString        *timeInterval;  //记录时间戳
@property (copy, nonatomic) NSString        *title;        //cell里显示的文字， 一般只有一个文字段， type 0 2 就都用这个了
@property (copy, nonatomic) NSArray         *contentImageURLArray;  // type 0 2 的图片URL数组
@property (copy, nonatomic) NSString        *contentVideoURL;   //视频URL
@property                   NSInteger       commendNumber;  //点赞次数
@property                   NSInteger       commentNumber;  //评论次数
@property                   NSInteger       relayNumber;  //评论次数

+ (instancetype) feedWithDictionary:(NSDictionary *) dictionary;

- (instancetype) initWithDictionary:(NSDictionary *) dictionary;

@end
