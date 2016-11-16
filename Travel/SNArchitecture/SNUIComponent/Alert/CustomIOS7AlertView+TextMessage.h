//
//  CustomIOS7AlertView+TextMessage.h
//  Bueaty
//
//  Created by 晓炜 郭 on 16/9/24.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "CustomIOS7AlertView.h"

@interface CustomIOS7AlertView (TextMessage)
//@property (nonatomic, strong, nullable) UILabel *messageLabel;

- (nullable instancetype)initWithMessage:(nullable NSString *)message delegate:(nullable id)delegate buttonTitles:(nullable NSArray *)buttonTitlesArray;

- (nullable instancetype)initWithMessage:(nullable NSString *)message delegate:(nullable id)delegate buttonTitles:(nullable NSArray *)buttonTitlesArray parentView:(nullable UIView *)parentView;

- (nullable instancetype)initWithMessage:(nullable NSString *)message textAlignment:(NSTextAlignment)textAlignment delegate:(nullable id)delegate buttonTitles:(nullable NSArray *)buttonTitlesArray;

- (nullable instancetype)initWithMessage:(nullable NSString *)message textAlignment:(NSTextAlignment)textAlignment delegate:(nullable id)delegate buttonTitles:(nullable NSArray *)buttonTitlesArray parentView:(nullable UIView *)parentView;

@end
