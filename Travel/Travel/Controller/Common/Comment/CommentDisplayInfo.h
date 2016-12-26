//
//  CommentDisplayInfo.h
//  Bueaty
//
//  Created by zhouzhenhua on 16/7/12.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentDisplayInfo : NSObject

@property CGFloat cellHeight;

@property CGRect imageRect;
@property CGRect userRect;
@property CGRect dateRect;
@property CGRect contentRect;
@property CGRect replyButtonRect;
@property CGRect replyTableBgRect;

@property CGFloat replyTotalHeight;

@property (nonatomic, strong) NSArray *replyRects;

@end
