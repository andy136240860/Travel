//
//  XWSegmentBar.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/26.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWSegmentBar.h"

@interface XWSegmentBar()

@property (nonatomic, strong) NSMutableArray    *titlesArr;
@property (nonatomic, strong) UIView            *lineView;
@property (nonatomic, assign) CGFloat           buttonWidth;

@end

@implementation XWSegmentBar

- (instancetype)init {
    self = [self initWithFrame:CGRectMake(0, 0, kScreenWidth, [[self class] defaultHeight])];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithTitls:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION {
    self = [self init];
    if(self) {
        NSString *other = nil;
        va_list args; //用于指向第一个参数
        _titlesArr = [NSMutableArray array];
        if(title){
            
            [_titlesArr addObject:title];
            va_start(args, title);//对args进行初始化，让它指向可变参数表里面的第一个参数
            
            while((other = va_arg(args, NSString*))){//获取指定类型的值
                [_titlesArr addObject:other];
            }
            va_end(args);//将args关闭
        }
        [self initButtons];
    }
    return self;
}

- (void)loadTitles:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION
{
    NSString *other = nil;
    va_list args; //用于指向第一个参数
    _titlesArr = [NSMutableArray array];
    if(title){
        
        [_titlesArr addObject:title];
        va_start(args, title);//对args进行初始化，让它指向可变参数表里面的第一个参数
        
        while((other = va_arg(args, NSString*))){//获取指定类型的值
            [_titlesArr addObject:other];
        }
        va_end(args);//将args关闭
    }
    [self initButtons];
}

- (void)initButtons {
    [self.subviews respondsToSelector:@selector(removeFromSuperview)];
    _buttonWidth = kScreenWidth / (_titlesArr.count == 0 ? 1:_titlesArr.count);
    for (int i = 0; i < _titlesArr.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i * _buttonWidth, 0, _buttonWidth, [self frameHeight])];
        [button setTitle:_titlesArr[i] forState:UIControlStateNormal];
        [button setTitleColor:kLightGrayColor forState:UIControlStateNormal];
        [button setTitleColor:kGreenColor forState:UIControlStateDisabled];
        button.tag = i;
        [button addTarget:self action:@selector(buttonSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (!i){
            [self buttonSelectedAction:button];
        }
    }
}

- (void)buttonSelectedAction:(UIButton *)sender {
    NSInteger lastButtonTag = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (button.enabled == NO) {
                lastButtonTag = button.tag;
                break;
            }
        }
    }
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (view.tag == sender.tag) {
                [button setEnabled:NO];
            }
            else {
                [button setEnabled:YES];
            }
        }
    }
    if ([self.delegate respondsToSelector:@selector(didSelectedTitleWithIndex:)]) {
        [self.delegate didSelectedTitleWithIndex:sender.tag];
    }
    CGSize titleSize = [sender.titleLabel.text sizeWithFont:sender.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, [[self class] defaultHeight])];
    CGFloat lineWidth = titleSize.width > _buttonWidth ? _buttonWidth :  titleSize.width;
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(sender.tag * _buttonWidth + (_buttonWidth - lineWidth)/2, [[self class] defaultHeight] - 2, lineWidth, 2)];
        _lineView.layer.backgroundColor = kGreenColor.CGColor;
        [self addSubview:_lineView];
    }
    else {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionCurveLinear animations:^{
            _lineView.frame = CGRectMake((lastButtonTag + sender.tag)/2 * _buttonWidth + 0.5 * _buttonWidth, _lineView.frameY, _buttonWidth, 2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.13 delay:0 options:UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionCurveLinear animations:^{
                _lineView.frame = CGRectMake(sender.tag * _buttonWidth + (_buttonWidth - lineWidth)/2, [[self class] defaultHeight] - 2, lineWidth, 2);
            } completion:nil];
        }];
//        [UIView animateWithDuration:0.2 animations:^{
//            _lineView.frame = CGRectMake((lastButtonTag + sender.tag)/2 * _buttonWidth + 0.5 * _buttonWidth, _lineView.frameY, _buttonWidth, 2);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.2 animations:^{
//                _lineView.frame = CGRectMake(sender.tag * _buttonWidth + (_buttonWidth - lineWidth)/2, [[self class] defaultHeight] - 2, lineWidth, 2);
//            }
//            completion:nil];
//        }];
//        [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
//            _lineView.frame = CGRectMake((lastButtonTag + sender.tag)/2 * _buttonWidth + 0.5 * _buttonWidth, _lineView.frameY, _buttonWidth, 2);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
//                _lineView.frame = CGRectMake(sender.tag * _buttonWidth + (_buttonWidth - lineWidth)/2, [[self class] defaultHeight] - 2, lineWidth, 2);
//            } completion:nil];
//        }];
//        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"frame"];
//        animation.duration = 0.2;
//        animation.values = @[[NSValue valueWithCGRect:CGRectMake((lastButtonTag + sender.tag)/2 * _buttonWidth + 0.5 * _buttonWidth, _lineView.frameY, _buttonWidth, 2)],
//                             [NSValue valueWithCGRect:CGRectMake(sender.tag * _buttonWidth + (_buttonWidth - lineWidth)/2, [[self class] defaultHeight] - 2, lineWidth, 2)]];
//        animation.keyTimes = @[@0.3f,@0.6f];
//        [_lineView.layer addAnimation:animation forKey:@"frame"];
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"frame"];
//        animation.fromValue = [NSValue valueWithCGRect:CGRectMake((lastButtonTag + sender.tag)/2 * _buttonWidth + 0.5 * _buttonWidth, _lineView.frameY, _buttonWidth, 2)];
//        animation.toValue = [NSValue valueWithCGRect:CGRectMake(sender.tag * _buttonWidth + (_buttonWidth - lineWidth)/2, [[self class] defaultHeight] - 2, lineWidth, 2)];
//        [_lineView.layer addAnimation:animation forKey:@"frame"];
    }
}

+ (CGFloat)defaultHeight {
    return 44;
}

@end
