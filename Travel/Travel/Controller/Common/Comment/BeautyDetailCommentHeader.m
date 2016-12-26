//
//  BeautyDetailCommentHeader.m
//  Bueaty
//
//  Created by zhouzhenhua on 16/4/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "BeautyDetailCommentHeader.h"

@implementation BeautyDetailCommentHeader
{
    UIView *titleLine;
    UILabel *titleLabel;
    UIView  *blankView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews
{
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frameWidth, 10)];
    topLineView.backgroundColor = kControllerGrayColor;;
    [self addSubview:topLineView];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frameWidth, kDefaultLineHeight)];
    line1.backgroundColor = kLightLineColor;;
    [topLineView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, topLineView.frameHeight, self.frameWidth, kDefaultLineHeight)];
    line2.backgroundColor = kLightLineColor;;
    [topLineView addSubview:line2];
    
    CGFloat padding = 10.0;
    CGFloat titleX = padding + 12.0;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, CGRectGetMaxY(topLineView.frame), 200 - titleX, 40)];
    titleLabel.textColor = kBlackColor;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.text = @"用户评论";
    [self addSubview:titleLabel];
    
    CGFloat titleLineHeight = 16.0;
    titleLine = [[UIView alloc] initWithFrame:CGRectMake(padding, 10, 4, titleLineHeight)];
    titleLine.centerY = titleLabel.centerY;
    titleLine.backgroundColor = kAppStyleColor;
    [self addSubview:titleLine];
    
    UIView *midLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), self.frameWidth, kDefaultLineHeight)];
    midLineView.backgroundColor = kLightLineColor;
    [self addSubview:midLineView];
    
    blankView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), self.frameWidth, 198)];
    blankView.backgroundColor = [UIColor clearColor];
    [self addSubview:blankView];
    
    UIImageView *blankImage = [[UIImageView alloc] initWithFrame:CGRectMake((blankView.frameWidth - 82) / 2, 20, 82, 110)];
    blankImage.image = [UIImage imageNamed:@"content_expression"];
    [blankView addSubview:blankImage];
    
    UILabel *blankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 145 - 1, blankView.frameWidth, 30)];
    blankLabel.backgroundColor = [UIColor clearColor];
    blankLabel.textColor = kBlackColor;
    blankLabel.font = [UIFont systemFontOfSize:12];
    blankLabel.numberOfLines = 2;
    blankLabel.text = @"还没有评论哦~\n赶紧来抢沙发~";
    blankLabel.textAlignment = NSTextAlignmentCenter;
    [blankView addSubview:blankLabel];
}

- (void)setHasComment:(BOOL)hasComment
{
    blankView.hidden = hasComment ? YES : NO;
    self.frameHeight = hasComment ? blankView.frameY : CGRectGetMaxY(blankView.frame);
}

@end
