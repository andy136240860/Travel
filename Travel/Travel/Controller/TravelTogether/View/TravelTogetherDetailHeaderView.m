//
//  TravelTogetherDetailHeaderView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/26.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "TravelTogetherDetailHeaderView.h"
#import "TravelDetailHeaderView.h"
#import "Masonry.h"


@interface TravelTogetherDetailHeaderView()

@property (nonatomic, strong) TravelDetailHeaderView *headerView;

@end

@implementation TravelTogetherDetailHeaderView

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self initSubView];
//    }
//    return self;
//}
//
//- (instancetype)init {
//    self = [self initWithFrame:CGRectMake(0, 0, kScreenWidth, [[self class] defaulHeight])];
//    return self;
//}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = kTableViewGrayColor;
//        self.backgroundColor = [UIColor redColor];
        [self initSubView];
        [self initAutoLayout];
    }
    return self;
}

- (void)initSubView {
    _headerView = [[TravelDetailHeaderView alloc]init];
    [self addSubview:_headerView];
    _segmentBar = [[XWSegmentBar alloc]initWithTitls:@"简介",@"人员",@"详情",@"说明",@"评论", nil];
    _segmentBar.frameY = CGRectGetMaxY(_headerView.frame);
    [self addSubview:_segmentBar];
    
    _travelTiTleAndDetailView = [[TravelTiTleAndDetailView alloc]init];
    [self addSubview:_travelTiTleAndDetailView];
    
    _travelMatesView = [[TravelMatesView alloc]init];
    [self addSubview:_travelMatesView];
    
    _travelTextAndImageDetailWebView = [[TravelTextAndImageDetailWebView alloc]init];
    [self addSubview:_travelTextAndImageDetailWebView];
}

- (void)initAutoLayout {
    CGFloat initialY = [TravelDetailHeaderView defaultHeight] + [XWSegmentBar defaultHeight];
    [_travelTiTleAndDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.mas_offset(initialY + 18);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(self.mas_width);
    }];
    [_travelMatesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_travelTiTleAndDetailView.mas_bottom).with.mas_offset(18);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(self.mas_width);
    }];
    [_travelTextAndImageDetailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_travelMatesView.mas_bottom).with.mas_offset(18);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(self.mas_width);
        make.bottom.mas_equalTo(self.mas_bottom).with.mas_offset(-18);
    }];
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    _travelTogether = travelTogether;
    _headerView.title = _travelTogether.title;
//    _headerView.subTitle =
    _headerView.avatarImageURL = _travelTogether.publisher.avatarURL;
    _headerView.backgroundImageURL = _travelTogether.coverImageURL;
    
    _travelTiTleAndDetailView.title = @"成都周边的一日游有什么比较漂亮的景点可以玩？";
    _travelTiTleAndDetailView.time = @"2016.08.16 19:23";
    _travelTiTleAndDetailView.price = @"2000-2500";
    
    _travelTextAndImageDetailWebView.HTMLString = _travelTogether.detail;
    [self performSelector:@selector(layoutIfNeeded) withObject:nil afterDelay:2];
    [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:2];
}

@end
