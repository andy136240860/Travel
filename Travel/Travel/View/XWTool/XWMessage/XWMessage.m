//
//  XWMessage.m
//  Travel
//
//  Created by 晓炜 郭 on 2017/1/2.
//  Copyright © 2017年 li na. All rights reserved.
//

#import "XWMessage.h"

typedef NS_ENUM(NSInteger, XWMessageStateType) {
    XWMessageStateTypeHide = 0,
    XWMessageStateTypeAnimation,
    XWMessageStateTypeShow
};

@interface XWMessage() {
    CGRect _messageViewFrame;
    CGRect _messageViewTempFrame;
    CGRect _tempWindowFrame;
    XWMessageStateType _messageState;
}

@property (nonatomic, strong) UIView                *messageView;
@property (nonatomic, strong) UIView                *backgroundView;
@property (nonatomic, strong) UIWindow              *tempWindow;

@end

@implementation XWMessage

+ (void)showMessageWithTitle:(NSString *)title message:(NSString *)message {
    XWMessage *xwmessage = [[XWMessage alloc]initWithTitle:title message:message notificationType:XWMessageNotificationTypeMessage];
    [xwmessage show];
}
+ (void)showWarningWithTitle:(NSString *)title message:(NSString *)message {
    XWMessage *xwmessage = [[XWMessage alloc]initWithTitle:title message:message notificationType:XWMessageNotificationTypeWarning];
    [xwmessage show];
}
+ (void)showErrorWithTitle:(NSString *)title message:(NSString *)message {
    XWMessage *xwmessage = [[XWMessage alloc]initWithTitle:title message:message notificationType:XWMessageNotificationTypeError];
    [xwmessage show];
}
+ (void)showSuccessWithTitle:(NSString *)title message:(NSString *)message {
    XWMessage *xwmessage = [[XWMessage alloc]initWithTitle:title message:message notificationType:XWMessageNotificationTypeSuccess];
    [xwmessage show];
}
+ (void)showWithTitle:(NSString *)title message:(NSString *)message notificationType:(XWMessageNotificationType)notificationType {
    XWMessage *xwmessage = [[XWMessage alloc]initWithTitle:title message:message notificationType:notificationType];
    [xwmessage show];
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.dismissWhenTouched = YES;
        self.holdTheFullView = NO;
        self.hasShadow = NO;
        self.duration = 2.0;
        self.notificationType = XWMessageNotificationTypeMessage;
        self.notificationPosition = TSMessageNotificationPositionTop;
        self.animationType = XWMessageAnimationFade;
        self.titleColor = [UIColor blackColor];
        self.messageColor = [UIColor blackColor];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message notificationType:(XWMessageNotificationType)notificationType {
    self = [self init];
    if (self) {
        self.title = title;
        self.message = message;
        self.notificationType = notificationType;
    }
    return self;
}

- (void)setNotificationType:(XWMessageNotificationType)notificationType {
    _notificationType = notificationType;
    switch (notificationType) {
        case XWMessageNotificationTypeWarning:
            self.icon = [UIImage imageNamed:@"XWMessageImageWarning"];
            break;
        case XWMessageNotificationTypeError:
            self.icon = [UIImage imageNamed:@"XWMessageImageError"];
            break;
        case XWMessageNotificationTypeSuccess:
            self.icon = [UIImage imageNamed:@"XWMessageImageSuccess"];
            break;
            
        default:
            break;
    }
}

- (void)setupView {
    if (_messageView) {
        [_messageView.subviews respondsToSelector:@selector(removeFromSuperview)];
    }
    if (_notificationPosition == TSMessageNotificationPositionTop || _notificationPosition == TSMessageNotificationPositionBottom) {
        CGFloat paddingTop = 12;
        CGFloat paddingLeft = 15;
        CGFloat initialX = 0;
        CGFloat iconWidth = 30;
        _messageView = [[UIView alloc]init];
        _messageView.frame = CGRectMake(paddingLeft, paddingTop, [UIScreen mainScreen].bounds.size.width - 2*paddingLeft, 100);
        _messageView.layer.cornerRadius = 8;
        _messageView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
        _messageView.layer.cornerRadius = 8;
        if (_hasShadow) {
            _messageView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
            _messageView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
            _messageView.layer.shadowRadius = 8;//阴影半径，默认3
        }
        if (_icon) {
            initialX = iconWidth + paddingLeft;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(paddingLeft, paddingTop, iconWidth, iconWidth)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = _icon;
            [_messageView addSubview:imageView];
        }
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(initialX + paddingLeft, paddingTop, _messageView.frame.size.width - initialX - 2*paddingLeft, 0)];
        if (_title) {
            titleLabel.text = _title;
            titleLabel.font = [UIFont systemFontOfSize:17];
            titleLabel.textColor = self.titleColor;
            titleLabel.numberOfLines = 0;
            [titleLabel sizeToFit];
            [_messageView addSubview:titleLabel];
        }
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(initialX + paddingLeft, paddingTop + CGRectGetMaxY(titleLabel.frame), _messageView.frame.size.width - initialX - 2*paddingLeft, 0)];
        if (_message) {
            messageLabel.text = _message;
            messageLabel.font = [UIFont systemFontOfSize:12];
            messageLabel.textColor = self.messageColor;
            messageLabel.numberOfLines = 0;
            [messageLabel sizeToFit];
            [_messageView addSubview:messageLabel];
        }
        CGFloat maxY = 0;
        for (UIView *view in _messageView.subviews) {
            CGFloat tempMaxY = CGRectGetMaxY(view.frame);
            if (tempMaxY > maxY) {
                maxY = tempMaxY;
            }
        }
        _tempWindowFrame = CGRectMake(paddingLeft, paddingTop, [UIScreen mainScreen].bounds.size.width - 2*paddingLeft, maxY + paddingTop);
        _messageView.frame = CGRectMake(0, 0, _tempWindowFrame.size.width, _tempWindowFrame.size.height);
        _messageViewFrame = _messageView.frame;
    }
}

- (void)show {
    [self setupView];
    if (_holdTheFullView) {
        _tempWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _messageViewFrame = _tempWindowFrame;
    }
    else {
        _tempWindow = [[UIWindow alloc]initWithFrame:_tempWindowFrame];
    }
    _tempWindow.windowLevel = 2000;
    [_tempWindow makeKeyAndVisible];
    
    [self showInView:_tempWindow];
}

- (void)showInView:(UIView *)view {
    _messageState = XWMessageStateTypeHide;
    if (_notificationPosition == TSMessageNotificationPositionTop) {
        _messageViewTempFrame = CGRectMake(_messageViewFrame.origin.x, _messageViewFrame.origin.y - _messageViewFrame.size.height - 20, _messageViewFrame.size.width, _messageViewFrame.size.height);
        self.messageView.frame = _messageViewTempFrame;
        if (self.animationType == XWMessageAnimationFade) {
            self.messageView.alpha = 0;
        }
    }
    _backgroundView = [[UIView alloc]initWithFrame:view.bounds];
    _backgroundView.userInteractionEnabled = _dismissWhenTouched;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [_backgroundView addGestureRecognizer:tap];
    [view addSubview:_backgroundView];
    [_backgroundView addSubview:self.messageView];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _messageState = XWMessageStateTypeAnimation;
        self.messageView.frame = _messageViewFrame;
        self.messageView.alpha = 1;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hide) withObject:nil afterDelay:self.duration];
        _messageState = XWMessageStateTypeShow;
    }];
}

- (void)hide {
    if (_messageState != XWMessageStateTypeShow) {
        return;
    }
    if (_messageView) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _backgroundView.alpha = 0;
            _messageView.frame = _messageViewTempFrame;
        } completion:^(BOOL finished) {
            [_backgroundView removeFromSuperview];
            _backgroundView = nil;
            [_messageView removeFromSuperview];
            _messageView = nil;
            _messageState = XWMessageStateTypeHide;
            if (_tempWindow) {
                [_tempWindow resignKeyWindow];
                _tempWindow = nil;
            }
        }];
    }
}

@end
