//
//  TravelTogetherDetailHeaderView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/26.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "TravelTogetherDetailHeaderView.h"
#import "TravelDetailHeaderView.h"

@interface TravelTogetherDetailHeaderView()

@property (nonatomic, strong) TravelDetailHeaderView *headerView;

@end

@implementation TravelTogetherDetailHeaderView

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
    _headerView = [[TravelDetailHeaderView alloc]init];
    [self addSubview:_headerView];
    _segmentBar = [[XWSegmentBar alloc]initWithTitls:@"简介",@"人员",@"详情",@"说明",@"评论", nil];
    _segmentBar.frameY = CGRectGetMaxY(_headerView.frame);
    [self addSubview:_segmentBar];
}

+ (CGFloat)defaulHeight {
    return [TravelDetailHeaderView defaultHeight] + [XWSegmentBar defaultHeight];
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    _travelTogether = travelTogether;
    _headerView.title = _travelTogether.title;
//    _headerView.subTitle =
    _headerView.avatarImageURL = _travelTogether.publisher.avatar;
    _headerView.backgroundImageURL = _travelTogether.headerViewBackgroundImageURL;
}

@end
