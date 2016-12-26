//
//  CommentListModel.h
//  Bueaty
//
//  Created by zhouzhenhua on 16/4/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "SNBaseListModel.h"

@class BeautyItem;

@interface CommentListModel : SNBaseListModel

@property (nonatomic, strong) BeautyItem *bueatyItem;

@property (nonatomic, strong) NSMutableArray *displayInfos;

@end
