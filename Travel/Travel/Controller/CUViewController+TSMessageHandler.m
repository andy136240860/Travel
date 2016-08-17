//
//  CUViewController+TSMessageHandler.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/15.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "CUViewController+TSMessageHandler.h"

@implementation CUViewController (TSMessageHandler)

- (void)showWarningWithTitle:(NSString *)title{
    [self showMessageWithTitle:title type:TSMessageNotificationTypeWarning];
}

- (void)showErrorWithTitle:(NSString *)title{
    [self showMessageWithTitle:title type:TSMessageNotificationTypeError];
}

- (void)showMessageWithTitle:(NSString *)title type:(TSMessageNotificationType)type{
    [self showMessageWithTitle:title subTitle:nil type:type];
}

- (void)showMessageWithTitle:(NSString *)title subTitle:(NSString *)subTitle type:(TSMessageNotificationType)type{
    self.navigationBar.hidden = YES;
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
