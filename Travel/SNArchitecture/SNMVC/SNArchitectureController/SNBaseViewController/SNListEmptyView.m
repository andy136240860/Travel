//
//  SNListEmptyView.m
//  CollegeUnion
//
//  Created by li na on 15/6/27.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import "SNListEmptyView.h"
#import "UIImage+Stretch.h"

@implementation SNListEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //
        self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imgView.frame = CGRectMake(0, 0, 82, 110);
        self.imgView.centerX = self.boundsWidth / 2;
        //self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imgView];
        
        //
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame) + 15 - 1, self.boundsWidth, 18)];
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
        [self.textLabel setTextColor:kBlackColor];
        [self.textLabel setFont:[UIFont systemFontOfSize:14.0]];
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textLabel];
        
        self.subTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textLabel.frame) + 10 - 1, self.boundsWidth, 18)];
        [self.subTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self.subTextLabel setTextColor:kBlackColor];
        [self.subTextLabel setFont:[UIFont systemFontOfSize:14.0]];
        self.subTextLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.subTextLabel];
        
        self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.actionButton.frame = CGRectMake(0, CGRectGetMaxY(self.subTextLabel.frame) + 40 - 1, 190, 44);
        self.actionButton.centerX = self.boundsWidth / 2;
        [self.actionButton setBackgroundImage:[[UIImage imageNamed:@"sign_button"] stretchableImageByCenter] forState:UIControlStateNormal];
        [self.actionButton setBackgroundImage:[[UIImage imageNamed:@"sign_button_selected"] stretchableImageByCenter] forState:UIControlStateNormal];
        [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.actionButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.actionButton addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.actionButton];
        
        //
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:gesture];
        
        self.type = SNListEmptyTypeNoData;
    }
    return self;
}

- (void)tapped:(UITapGestureRecognizer *)gesture
{
//    if ([self.delegate respondsToSelector:@selector(emptyViewClicked)])
//    {
//        [self.delegate emptyViewClicked];
//    }
}

- (void)buttonPress
{
    if ([self.delegate respondsToSelector:@selector(emptyViewClicked)])
    {
        [self.delegate emptyViewClicked];
    }
}

- (void)setType:(SNListEmptyType)type
{
    _type = type;
    
    if (type == SNListEmptyTypeNoData) {
        [self.imgView setImage:[UIImage imageNamed:@"search_expression"]];
        [self.textLabel setText:@"对不起！没有加载到数据"];
        [self.subTextLabel setText:@"请刷新重试"];
        self.actionButton.hidden = NO;
        [self.actionButton setTitle:@"再试一下" forState:UIControlStateNormal];
    }
    else if (type == SNListEmptyTypeDataError) {
        [self.imgView setImage:[UIImage imageNamed:@"me_error_expression"]];
        [self.textLabel setText:@"这个页面正在闹脾气~"];
        [self.subTextLabel setText:@"再刷新试试~~"];
        self.actionButton.hidden = NO;
        [self.actionButton setTitle:@"试试就试试" forState:UIControlStateNormal];
    }
    else if (type == SNListEmptyTypeNoSearchResult) {
        [self.imgView setImage:[UIImage imageNamed:@"search_expression"]];
        [self.textLabel setText:@"搜索不到内容"];
        [self.subTextLabel setText:nil];
        self.actionButton.hidden = YES;
    }
    else if (type == SNListEmptyTypeNoFavorite) {
        [self.imgView setImage:[UIImage imageNamed:@"me_collection_expression"]];
        [self.textLabel setText:@"没有收藏的话题"];
        [self.subTextLabel setText:nil];
        self.actionButton.hidden = YES;
    }
    else if (type == SNListEmptyTypeNoFavorite) {
        [self.imgView setImage:[UIImage imageNamed:@"me_collection_expression"]];
        [self.textLabel setText:@"没有评论哦"];
        [self.subTextLabel setText:nil];
        self.actionButton.hidden = YES;
    }
    else if (type == SNListEmptyTypeNoFavorite) {
        [self.imgView setImage:[UIImage imageNamed:@"me_collection_expression"]];
        [self.textLabel setText:@"没有消息哦"];
        [self.subTextLabel setText:nil];
        self.actionButton.hidden = YES;
    }
}

@end
