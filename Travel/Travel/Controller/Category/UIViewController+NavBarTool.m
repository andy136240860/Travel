//
//  UIViewController+NavBarTool.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/17.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "UIViewController+NavBarTool.h"

@implementation UIViewController (NavBarTool)

- (void)useTranslucentBackgroundImage
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
               forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)useDefaultNavBarTitleColor{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)addRightButtonWithTitle:(NSString *)title seletor:(SEL)selector{
    UIBarButtonItem *resignItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.rightBarButtonItem = resignItem;
}


@end
