//
//  UIViewController+TitleView.m
//  HuiYangChe
//
//  Created by zhouzhenhua on 14-9-14.
//  Copyright (c) 2014年 li na. All rights reserved.
//

#import "UIViewController+TitleView.h"
//#import "SystemConstant.h"
#import "SNUISystemConstant.h"
//#import "SNSlideDefines.h"
#import <objc/runtime.h>
#import "CUUIContant.h"

#define kNavOffset_Y                 (IS_IOS7 ? 20 : 0)

@implementation UIViewController (TitleView)

- (UILabel *)createNavTitleLabel:(NSString *)title
{
    CGFloat maxWidth = kScreenWidth - (44 + 10) * 2;
    CGRect titleRect = CGRectMake(0, 0, maxWidth, 44);
    UILabel *titleViewLabel = [[UILabel alloc] init];
    titleViewLabel.font = [UIFont systemFontOfSize:17];
    titleViewLabel.textColor = UIColorFromHex(Color_Hex_NavText_Normal);
    titleViewLabel.text = title;
    titleViewLabel.backgroundColor = [UIColor clearColor];
    titleViewLabel.textAlignment = NSTextAlignmentCenter;
    titleViewLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    CGSize titleSize = [titleViewLabel.text sizeWithFont:titleViewLabel.font];
    if (ceilf(titleSize.width) < maxWidth) {
        titleRect.size.width = ceilf(titleSize.width);
    }
    titleViewLabel.frame = titleRect;
    
    return titleViewLabel;
}

- (void)changeNaigationTitle:(NSString *)title
{
    UILabel *titleLabel = [self createNavTitleLabel:title];
    titleLabel.textColor = [self getCurrentNavTitleColor] ? [self getCurrentNavTitleColor] : titleLabel.textColor;
    
    UIView *labelBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleLabel.frame), CGRectGetHeight(titleLabel.frame))];
    [labelBg addSubview:titleLabel];
    
    if (0 && self.tabBarController) {
        self.tabBarController.navigationItem.titleView = labelBg;
    }
    else {
        self.navigationItem.titleView = labelBg;
    }
}

- (void)changeNaigationTitleColor:(UIColor *)titleColor
{
    [self setCurrentNavTitleColor:titleColor];
    
    UIView *labelBg = self.navigationItem.titleView;
    if (self.tabBarController) {
        labelBg = self.tabBarController.navigationItem.titleView;
    }
    UILabel *label = [labelBg.subviews objectAtIndexSafely:0];
    if ([label isKindOfClass:[UILabel class]]) {
        label.textColor = titleColor;
    }
}

// 重写title显示
- (void)setTitle:(NSString *)title
{
    [self setCurrentNavTitle:title];
    
    [self changeNaigationTitle:title];
}

- (NSString *)title
{
    return [self getCurrentNavTitle];
}

- (NSString *)getCurrentNavTitle
{
    return objc_getAssociatedObject(self, "CU_CurrentNavTitle");
}

- (void)setCurrentNavTitle:(NSString *)title
{
    objc_setAssociatedObject(self, "CU_CurrentNavTitle", title, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)getCurrentNavTitleColor
{
    return objc_getAssociatedObject(self, "CU_CurrentNavTitleColor");
}

- (void)setCurrentNavTitleColor:(UIColor *)titleColor
{
    objc_setAssociatedObject(self, "CU_CurrentNavTitleColor", titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
