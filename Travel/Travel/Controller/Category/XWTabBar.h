//
//  XWTabBar.h
//  Travel
//
//  Created by 晓炜 郭 on 16/8/17.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XWTabBar;

@protocol XWTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(XWTabBar *)tabBar;

@end

@interface XWTabBar : UITabBar

@property (nonatomic, weak) id<XWTabBarDelegate> delegate;
@property (nonatomic, weak) UIButton *plusBtn;

@end
