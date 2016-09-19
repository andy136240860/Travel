//
//  XWTabBar.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/17.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTabBar.h"
#import "UIView+Extension.h"
#import "UIImage+Color.h"


@interface XWTabBar ()


@end

@implementation XWTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]]];
        [self setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];
        self.translucent = NO;
        
        UIButton *plusBtn = [[UIButton alloc] init];
//        plusBtn.size = CGSizeMake(60, 60);
        plusBtn.layer.cornerRadius = 32.f;
        plusBtn.clipsToBounds = YES;
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabar_PlusButton"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabar_PlusButton"] forState:UIControlStateHighlighted];
        
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        plusBtn.userInteractionEnabled = YES;
        self.plusBtn = plusBtn;
    }
    return self;
}

/**
 *  加号按钮点击
 */
- (void)plusBtnClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

/**
 *  想要重新排布系统控件subview的布局，推荐重写layoutSubviews，在调用父类布局后重新排布。
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    self.plusBtn.centerX = self.frameWidth*0.5;
    self.plusBtn.centerY = self.frameHeight*0.5-8;
    
    // 2.设置其他tabbarButton的frame
    CGFloat tabBarButtonW = self.frameWidth / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置x
            child.frameX = tabBarButtonIndex * tabBarButtonW;
            // 设置宽度
            child.frameWidth = tabBarButtonW;
            // 增加索引
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
    [self bringSubviewToFront:self.plusBtn];
}

@end
