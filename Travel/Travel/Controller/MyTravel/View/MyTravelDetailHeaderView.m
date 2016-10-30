//
//  MyTravelDetailHeaderView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/9.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "MyTravelDetailHeaderView.h"
#import "TravelDetailHeaderView.h"

@implementation MyTravelDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (instancetype)init {
    self = [self initWithFrame:CGRectMake(0, 0, kScreenWidth, [[self class] defaulHeight])];
    return self;
}

- (void)initSubView {
    TravelDetailHeaderView *headerView = [[TravelDetailHeaderView alloc]init];
    [self addSubview:headerView];
}

+ (CGFloat)defaulHeight {
    return [TravelDetailHeaderView defaultHeight];
}

@end
