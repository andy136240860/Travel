//
//  CUViewController+Login.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/4.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "CUViewController+Login.h"
#import "CUUserManager.h"
#import "LoginOrRegisterVC.h"

@implementation CUViewController (Login)

- (void)pushViewControllerWithVerifyLogin:(SNViewController *)viewController animated:(BOOL)animated
{
    if ([[CUUserManager sharedInstance] isLogin]) {
        [self.slideNavigationController pushViewController:viewController animated:animated];
    }
    else{
        
        LoginOrRegisterVC *loginVC = [[LoginOrRegisterVC alloc]initWithPageName:NSStringFromClass([LoginOrRegisterVC class])];
        SNSlideNavigationController *navVC = [[SNSlideNavigationController alloc]initWithRootViewController:loginVC];
        [self.slideNavigationController  presentViewController:navVC animated:YES completion:nil];
    }

}

@end
