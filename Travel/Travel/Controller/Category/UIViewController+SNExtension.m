//
//  UIViewController+SNViewController.m
//  YCGY
//
//  Created by Na Li on 15/11/27.
//  Copyright © 2015年 li na. All rights reserved.
//

#import "UIViewController+SNExtension.h"
#import "CUUIContant.h"
#import <objc/runtime.h>

static  const void* pageNameKey = &pageNameKey;

@implementation UIViewController (SNExtension)

- (void)setPageName:(NSString *)pageName
{
    objc_setAssociatedObject(self,pageNameKey,pageName,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)pageName
{
    return objc_getAssociatedObject(self, pageNameKey);
}

- (instancetype)initWithPageName:(NSString *)pageName
{
    if (self = [self init])
    {
        self.pageName = pageName;
    }
    return self;
}

@end


#pragma mark ------------------- UIViewController (HUD) --------------------

static  const void* progressViewKey = &progressViewKey;

@implementation UIViewController (HUD)

- (void)setProgressView:(MBProgressHUD *)progressView
{
    objc_setAssociatedObject(self,progressViewKey,progressView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)progressView
{
    return objc_getAssociatedObject(self, progressViewKey);
}

- (void)showProgressView
{
    if (self.progressView == nil) {
        self.progressView = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        self.progressView.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2.0, CGRectGetHeight(self.view.bounds)/2.0);
        [self.view addSubview:self.progressView];
        self.progressView.dimBackground = NO;
        self.progressView.opacity = 0.1;
    }
    
    [self.view bringSubviewToFront:self.progressView];
    [self.progressView show:YES];
    self.view.userInteractionEnabled = NO;
}

- (void)hideProgressView
{
    [self.progressView hide:NO];
    self.view.userInteractionEnabled = YES;
}


@end

#pragma mark ------------------- UIViewController (Nav) --------------------

@implementation UIViewController (Nav)

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)closeAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)addLeftBackButtonItemWithImage
{
    [self addLeftItemWithImage:[UIImage imageNamed:ImgStr_BackBtn] hilightImage:nil title:nil target:self action:@selector(backAction)];
}

- (void)addLeftCloseButtonItemWithImage
{
    [self addLeftItemWithImage:[UIImage imageNamed:imgStr_CloseBtn] hilightImage:nil title:nil target:self action:@selector(closeAction)];
}

- (void)addLeftBackButtonItemWithImageAndTitle
{
    [self addLeftItemWithImage:[UIImage imageNamed:ImgStr_BackBtn] hilightImage:nil title:@"返回" target:self action:@selector(backAction)];
}

- (void)addLeftCloseButtonItemWithTitle
{
    [self addLeftItemWithImage:nil hilightImage:nil title:@"关闭" target:self action:@selector(closeAction)];
}

- (void)addLeftCloseButtonItemWithImageAndTitle
{
    [self addLeftItemWithImage:[UIImage imageNamed:imgStr_CloseBtn] hilightImage:nil title:@"关闭" target:self action:@selector(closeAction)];
}


- (UIBarButtonItem *)newButtonItemWithTitleAndImage:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)selector
{
    UIView* leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.backgroundColor = [UIColor clearColor];
    leftButton.frame = leftButtonView.frame;
    [leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftButton setTitle:title forState:UIControlStateNormal];
    leftButton.tintColor = UIColorFromHex(Color_Hex_NavItem_Normal);
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 0);
    
    [leftButton addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonView addSubview:leftButton];
    
    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
    
    return leftBarButton;
    
}

- (void)addLeftItemWithImage:(UIImage *)image hilightImage:(UIImage *)hilightImage title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImage:hilightImage forState:UIControlStateHighlighted];
    [leftButton setTitle:title forState:UIControlStateNormal];
    leftButton.tintColor = UIColorFromHex(Color_Hex_NavItem_Normal);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (image && title) {
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    
    CGFloat viewWidth = 0.0;
    CGSize titleSize = [title sizeWithFont:leftButton.titleLabel.font];
    if ((int)titleSize.width && image.size.width) {
        viewWidth = ceilf(titleSize.width) + image.size.width + 20;
    }
    else if ((int)titleSize.width) {
        viewWidth = ceilf(titleSize.width) + 10;
    }
    else if (image.size.width) {
        viewWidth = image.size.width + 10;
    }
    
    CGFloat minWidth = 40.0;
    if (viewWidth < minWidth) {
        viewWidth = minWidth;
    }
    
    leftButton.frame = CGRectMake(0, 0, viewWidth, 44);
    
    [self addLeftItemWithView:leftButton];
}

- (void)addLeftItemWithView:(UIView *)view
{
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(IOS_7_0)) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        
        if (self.tabBarController) {
            self.tabBarController.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarItem];
        }
        else {
            self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarItem];
        }
    }
    else {
        if (self.tabBarController) {
            self.tabBarController.navigationItem.leftBarButtonItem = leftBarItem;
        }
        else {
            self.navigationItem.leftBarButtonItem = leftBarItem;
        }
    }
}

- (void)clearNavigationItem
{
    [self clearLeftItem];
    [self clearRightItem];
}

- (void)clearLeftItem
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(IOS_7_0)) {
        if (self.tabBarController) {
            self.tabBarController.navigationItem.leftBarButtonItems = nil;
        }
        else {
            self.navigationItem.leftBarButtonItems = nil;
        }
    }
    else {
        if (self.tabBarController) {
            self.tabBarController.navigationItem.leftBarButtonItem = nil;
        }
        else {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
}

- (void)clearRightItem
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(IOS_7_0)) {
        if (self.tabBarController) {
            self.tabBarController.navigationItem.rightBarButtonItems = nil;
        }
        else {
            self.navigationItem.rightBarButtonItems = nil;
        }
    }
    else {
        if (self.tabBarController) {
            self.tabBarController.navigationItem.rightBarButtonItem = nil;
        }
        else {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
}

+ (UIBarButtonItem *)rightItemWithImage:(UIImage *)image hilightImage:(UIImage *)hilightImage target:(id)target action:(SEL)action
{
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    buttonView.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = buttonView.bounds;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:hilightImage forState:UIControlStateHighlighted];
    [buttonView addSubview:button];
    
    return [[UIBarButtonItem alloc] initWithCustomView:buttonView];
}

+ (UIView *)rightItemViewWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    CGSize titleSize = [title sizeWithFont:titleFont];
    titleSize.width = ceilf(titleSize.width);
    
    float labelPadding = 15;
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleSize.width + labelPadding * 2, 44)];
    buttonView.backgroundColor = [UIColor clearColor];
    
    CGFloat buttonHeight = 40.0;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, (CGRectGetHeight(buttonView.frame) - buttonHeight) / 2, CGRectGetWidth(buttonView.frame), buttonHeight);
    button.titleLabel.font = titleFont;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kGreenColor forState:UIControlStateNormal];
    [button setTitleColor:[kGreenColor colorWithAlphaComponent:.3] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [buttonView addSubview:button];
    
    return buttonView;
}

+ (UIBarButtonItem *)rightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIView *buttonView = [self rightItemViewWithTitle:title target:target action:action];

    return [[UIBarButtonItem alloc] initWithCustomView:buttonView];
}

- (void)addRightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIView *buttonView = [self.class rightItemViewWithTitle:title target:target action:action];
    
    [self addRightItemWithView:buttonView];
}

- (void)addRightItemWithView:(UIView *)view
{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(IOS_7_0)) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        
        if (self.tabBarController) {
            self.tabBarController.navigationItem.rightBarButtonItems = @[negativeSpacer, rightBarItem];
        }
        else {
            self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightBarItem];
        }
    }
    else {
        if (self.tabBarController) {
            self.tabBarController.navigationItem.rightBarButtonItem = rightBarItem;
        }
        else {
            self.navigationItem.rightBarButtonItem = rightBarItem;
        }
    }
}

@end

#pragma mark ------------------ UIViewController (Deprecated) ------------------
@implementation UIViewController (Deprecated)

- (void)setHasTab:(BOOL)hasTab
{
    
}

- (BOOL)hasTab
{
    return self.hidesBottomBarWhenPushed;
}

- (void)setShouldHaveTab:(BOOL)haveTab
{
    
}

@end

