//
//  CUViewController+Login.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/4.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "UIViewController+Login.h"
#import "XWUser.h"
#import "LoginOrRegisterVC.h"

@implementation UIViewController (Login)

- (void)pushViewControllerWithVerifyLogin:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([[XWUser currentUser] isAuthenticated]) {
        [self.navigationController pushViewController:viewController animated:animated];
    }
    else{
        LoginOrRegisterVC *loginVC = [[LoginOrRegisterVC alloc]init];
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self.navigationController presentViewController:navVC animated:YES completion:nil];
    }

}

- (void)loginAction {
    LoginOrRegisterVC *loginVC = [[LoginOrRegisterVC alloc]init];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self.navigationController presentViewController:navVC animated:YES completion:nil];
}

@end
