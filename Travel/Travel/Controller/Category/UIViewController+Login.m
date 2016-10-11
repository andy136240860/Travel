//
//  CUViewController+Login.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/4.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "UIViewController+Login.h"
#import "AVUser.h"
#import "LoginOrRegisterVC.h"

@implementation UIViewController (Login)

- (void)pushViewControllerWithVerifyLogin:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([[AVUser currentUser] isAuthenticated]) {
        [self.navigationController pushViewController:viewController animated:animated];
    }
    else{
        LoginOrRegisterVC *loginVC = [[LoginOrRegisterVC alloc]init];
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self.navigationController presentViewController:navVC animated:animated completion:nil];
    }
}

@end
