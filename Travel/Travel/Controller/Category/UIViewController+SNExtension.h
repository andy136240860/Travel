//
//  UIViewController+SNViewController.h
//  YCGY
//
//  Created by Na Li on 15/11/27.
//  Copyright © 2015年 li na. All rights reserved.
//  公用的UIViewController

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface UIViewController (SNExtension)

/**
 *  必填：填写后可以统一处理对页面所有接口的取消
 */
@property (nonatomic,strong) NSString * pageName;


- (instancetype)initWithPageName:(NSString *)pageName;

@end


@interface UIViewController (HUD)

@property (nonatomic,strong) MBProgressHUD * progressView;

- (void)showProgressView;
- (void)hideProgressView;

@end


/**
 *  1、给所有的UIViewController添加返回或者关闭
 *  2、所有的UIViewController添加返回和关闭操作
 */
@interface UIViewController (Nav)

- (void)backAction;
- (void)closeAction;

/** < 返回 **/
- (void)addLeftBackButtonItemWithImageAndTitle;
/** < **/
- (void)addLeftBackButtonItemWithImage;
/** 返回 **/
//- (void)addLeftBackButtonItemWithTitle;

/** x 关闭 **/
- (void)addLeftCloseButtonItemWithImageAndTitle;
/** x **/
- (void)addLeftCloseButtonItemWithImage;
/** 关闭 **/
- (void)addLeftCloseButtonItemWithTitle;

- (void)addLeftItemWithImage:(UIImage *)image hilightImage:(UIImage *)hilightImage title:(NSString *)title target:(id)target action:(SEL)action;

- (void)clearNavigationItem;
- (void)clearLeftItem;
- (void)clearRightItem;

- (void)addRightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

- (void)addLeftItemWithView:(UIView *)view;
- (void)addRightItemWithView:(UIView *)view;

@end

@interface UIViewController (Deprecated)

@property (nonatomic,assign) BOOL hasTab __deprecated_msg("propety deprecated. remove it,use hidesBottomBarWhenPushed");
- (void)setShouldHaveTab:(BOOL)haveTab __deprecated_msg("Method deprecated. remove it,use hidesBottomBarWhenPushed");

@end