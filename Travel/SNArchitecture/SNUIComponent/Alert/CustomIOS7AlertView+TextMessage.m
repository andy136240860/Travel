//
//  CustomIOS7AlertView+TextMessage.m
//  Bueaty
//
//  Created by 晓炜 郭 on 16/9/24.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "CustomIOS7AlertView+TextMessage.h"

@implementation CustomIOS7AlertView (TextMessage)
//@dynamic messageLabel;

- (nullable instancetype)initWithMessage:(nullable NSString *)message delegate:(nullable id)delegate buttonTitles:(nullable NSArray *)buttonTitlesArray {
    self = [[CustomIOS7AlertView alloc] initWithMessage:message delegate:delegate buttonTitles:buttonTitlesArray parentView:[[UIApplication sharedApplication] keyWindow]];
    return self;
}

- (nullable instancetype)initWithMessage:(nullable NSString *)message delegate:(nullable id)delegate buttonTitles:(nullable NSArray *)buttonTitlesArray parentView:(nullable UIView *)parentView {
    self = [[CustomIOS7AlertView alloc] initWithMessage:message textAlignment:NSTextAlignmentLeft delegate:delegate buttonTitles:buttonTitlesArray];
    return self;
}

- (nullable instancetype)initWithMessage:(nullable NSString *)message textAlignment:(NSTextAlignment)textAlignment delegate:(nullable id)delegate buttonTitles:(nullable NSArray *)buttonTitlesArray {
    self = [[CustomIOS7AlertView alloc] initWithMessage:message textAlignment:textAlignment delegate:delegate buttonTitles:buttonTitlesArray parentView:[[UIApplication sharedApplication] keyWindow]];
    return self;
}

- (nullable instancetype)initWithMessage:(nullable NSString *)message textAlignment:(NSTextAlignment)textAlignment delegate:(nullable id)delegate buttonTitles:(nullable NSArray *)buttonTitlesArray parentView:(nullable UIView *)parentView {
    self = [[CustomIOS7AlertView alloc]init];
    if (self) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:12];//调整行间距
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [message length])];
        
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 0)];
        messageLabel.attributedText = attributedString;
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont systemFontOfSize:15];
        messageLabel.textColor = UIColorFromHex(0x959595);
        messageLabel.textAlignment = textAlignment;
        [messageLabel sizeToFit];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, messageLabel.frameHeight + 50)];
        view.backgroundColor = [UIColor whiteColor];
        messageLabel.center = view.center;
        [view addSubview:messageLabel];
        
        self.buttonTextFontSize = 15;
        self.buttonBackgroundColorNormal = [UIColor whiteColor];
        self.delegate = delegate;
        [self setContainerView:view];
        [self setParentView:parentView];
        [self setButtonTitles:buttonTitlesArray];
        self.buttonTextColorNormal = kGreenColor;
        self.buttonTextColorHighlighted = UIColorFromHex(0xfd7974);
        if (buttonTitlesArray.count == 2) {
            [self setButtonTitlesTextColerNormal:@[UIColorFromHex(0x959595),kGreenColor]];
            [self setButtonTitlesTextColerHighlighted:@[UIColorFromHex(0x959595),UIColorFromHex(0xfd7974)]];
        }
    }
    return self;
}

@end
