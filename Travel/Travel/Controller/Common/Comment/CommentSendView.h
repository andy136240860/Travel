//
//  CommentSendView.h
//  Bueaty
//
//  Created by zhouzhenhua on 16/4/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentSendViewDelegate;

typedef void (^CommentSendViewBlock)(NSString *content);

@interface CommentSendView : UIView

@property (nonatomic, copy) CommentSendViewBlock sendAction;
@property (nonatomic, copy) CUButtonBlock cancelAction;

@property (nonatomic, strong) NSString *currentText;
@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, weak) id<CommentSendViewDelegate> delegate;

- (void)show;
- (void)hide;
- (void)resetView;

@end

@protocol CommentSendViewDelegate <NSObject>

- (void)commentSendViewDidShow:(CommentSendView *)sendView position:(CGFloat)position;

@end