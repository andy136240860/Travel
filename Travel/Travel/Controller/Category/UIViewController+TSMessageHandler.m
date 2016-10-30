//
//  CUViewController+TSMessageHandler.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/15.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "UIViewController+TSMessageHandler.h"

@implementation UIViewController (TSMessageHandler)

- (void)showWarningWithTitle:(NSString *)title{
    [TSMessage showNotificationWithTitle:title type:TSMessageNotificationTypeWarning];
}

- (void)showErrorWithTitle:(NSString *)title{
    [TSMessage showNotificationWithTitle:title type:TSMessageNotificationTypeError];
}

- (void)showMessageWithTitle:(NSString *)title type:(TSMessageNotificationType)type{
    [TSMessage showNotificationWithTitle:title type:type];
}

- (void)showMessageWithTitle:(NSString *)title subTitle:(NSString *)subTitle type:(TSMessageNotificationType)type{
    if (self.navigationController.navigationBarHidden == NO) {
        self.navigationController.navigationBarHidden = YES;
    }//必须要加
    [TSMessage showNotificationInViewController:self
                                          title:title
                                       subtitle:subTitle
                                          image:nil
                                           type:type
                                       duration:2
                                       callback:nil
                                    buttonTitle:nil
                                 buttonCallback:^{
                                     NSLog(@"按钮事件");
                                 }
                                     atPosition:TSMessageNotificationPositionNavBarOverlay
                           canBeDismissedByUser:YES];
}

@end
