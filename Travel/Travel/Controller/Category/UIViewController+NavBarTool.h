//
//  UIViewController+NavBarTool.h
//  Travel
//
//  Created by 晓炜 郭 on 16/8/17.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavBarTool)

- (void)Nav_useTranslucentBackgroundImage; //使用透明的NavBar

- (void)Nav_useDefaultNavBarTitleColor;  //使用自定义的tintColor

- (void)Nav_addRightButtonWithTitle:(NSString *)title seletor:(SEL)selector;

@end
