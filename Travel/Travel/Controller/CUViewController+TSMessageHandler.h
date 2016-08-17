//
//  CUViewController+TSMessageHandler.h
//  Travel
//
//  Created by 晓炜 郭 on 16/8/15.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "CUViewController.h"
#import "TSMessage.h"

@interface CUViewController (TSMessageHandler)

- (void)showWarningWithTitle:(NSString *)title;
- (void)showErrorWithTitle:(NSString *)title;
- (void)showMessageWithTitle:(NSString *)title type:(TSMessageNotificationType)type;
- (void)showMessageWithTitle:(NSString *)title subTitle:(NSString *)subTitle type:(TSMessageNotificationType)type;

@end
