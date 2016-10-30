//
//  EditTravelTogetherHeaderView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/13.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "EditTravelTogetherHeaderView.h"

@implementation EditTravelTogetherHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self initSubView];
    }
    return self;
}

- (instancetype)init {
    self = [self initWithFrame:CGRectMake(0, 0, kScreenWidth, [[self class] defaultHeight])];
    return self;
}

- (void)initSubView {
    CGFloat buttonDiamater = 75;
    CGFloat labelBgViewHeight = 18*5;
    
    _backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _backgroundImageView.clipsToBounds = YES;
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.image = [UIImage imageNamed:@"TravelHeaderViewBG.jpg"];
    _backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:_backgroundImageView];
    
    UIView *labelBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _backgroundImageView.frameHeight - labelBgViewHeight, kScreenWidth, labelBgViewHeight)];
    labelBgView.layer.contents = (id)[UIImage imageNamed:@"EditTravelTogeterHeaderViewLabelBackground"].CGImage;
    [_backgroundImageView addSubview:labelBgView];
    
    _titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, labelBgView.frameHeight - 54, kScreenWidth, 54)];
    _titleTextField.textColor = [UIColor whiteColor];
    _titleTextField.placeholder = @"点此输入标题";
    [_titleTextField setValue:[[UIColor whiteColor] colorWithAlphaComponent:0.8] forKeyPath:@"_placeholderLabel.textColor"];
    _titleTextField.font = [UIFont systemFontOfSize:15];
    _titleTextField.textAlignment = NSTextAlignmentCenter;
    _titleTextField.userInteractionEnabled = YES;
    [labelBgView addSubview:_titleTextField];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((_backgroundImageView.frameWidth - buttonDiamater)/2.f, (_backgroundImageView.frameHeight - 18*2 - buttonDiamater)/2.f, buttonDiamater, buttonDiamater)];
    [button setImage:[UIImage imageNamed:@"changeImageButtonNormal"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"changeImageButtonHighLighted"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(ChangeImageAction) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImageView addSubview:button];
}

- (void)ChangeImageAction {
    if ([self.delegate respondsToSelector:@selector(ChangeBackgroundImageWithEditTravelTogetherHeaderView:)]) {
        [self.delegate ChangeBackgroundImageWithEditTravelTogetherHeaderView:self];
    }
}

+ (CGFloat)defaultHeight {
    return 150;
}

@end
