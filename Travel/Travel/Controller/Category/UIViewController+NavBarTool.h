//
//  UIViewController+NavBarTool.h
//  Travel
//
//  Created by 晓炜 郭 on 16/8/17.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavBarTool)

- (void)useTranslucentBackgroundImage; //使用透明的NavBar

- (void)useDefaultNavBarTitleColor;  //使用自定义的tintColor

- (void)addRightButtonWithTitle:(NSString *)title seletor:(SEL)selector;

@end
