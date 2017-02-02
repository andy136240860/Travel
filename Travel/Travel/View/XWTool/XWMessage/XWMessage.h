//
//  XWMessage.h
//  Travel
//
//  Created by 晓炜 郭 on 2017/1/2.
//  Copyright © 2017年 li na. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XWMessage;

typedef NS_ENUM(NSInteger, XWMessageNotificationType) {
    XWMessageNotificationTypeMessage = 0,
    XWMessageNotificationTypeWarning,
    XWMessageNotificationTypeError,
    XWMessageNotificationTypeSuccess
};

typedef NS_ENUM(NSInteger, XWMessageNotificationPosition) {
    TSMessageNotificationPositionTop = 0,
    TSMessageNotificationPositionCenter,
    TSMessageNotificationPositionBottom
};

typedef NS_ENUM(NSInteger, XWMessageAnimation) {
    XWMessageAnimationFade = 0,
    XWMessageAnimationSlip,
};

@protocol XWMessageDelegate <NSObject>

- (void)messageWillShow:(XWMessage *)message;
- (void)didClickedMessage:(XWMessage *)message;
- (void)messageWillHide:(XWMessage *)message;

@end


@interface XWMessage : NSObject

@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) UIColor   *titleColor;
@property (nonatomic, strong) NSString  *message;
@property (nonatomic, strong) UIColor   *messageColor;
@property (nonatomic, strong) UIImage   *icon;

@property (nonatomic, assign) BOOL dismissWhenTouched; //defult is YES
@property (nonatomic, assign) BOOL holdTheFullView; // defult is Yes //If you the domain you clicked is in the view you set and beyound the messageView, the delegate will response
@property (nonatomic, assign) BOOL hasShadow; //defult is YES

@property (nonatomic, assign) NSTimeInterval duration; //defult is 2.0

@property (nonatomic, assign) XWMessageNotificationType notificationType;
@property (nonatomic, assign) XWMessageNotificationPosition notificationPosition;
@property (nonatomic, assign) XWMessageAnimation animationType;

@property (nonatomic, copy) id <XWMessageDelegate> delegate;

+ (void)showMessageWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showWarningWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showErrorWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showSuccessWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message notificationType:(XWMessageNotificationType)notificationType;

- (instancetype)init;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message notificationType:(XWMessageNotificationType)notificationType;
- (void)show; // defult is [UIApplication sharedApplication].keyWindow

- (void)hide;

@end
