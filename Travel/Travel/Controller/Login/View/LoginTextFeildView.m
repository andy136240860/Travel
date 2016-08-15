//
//  LoginTextFeildView.m
//  FindDoctor
//
//  Created by 晓炜 郭 on 16/1/9.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "LoginTextFeildView.h"
@interface LoginTextFeildView ()<UITextFieldDelegate>{
    UIImage *_image;
    UIView  *_lineView;
    NSString *_title;
    BOOL     _hasTitleLine;
}


@end

@implementation LoginTextFeildView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image{
    self = [self initWithFrame:frame image:image canEidt:YES];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image canEidt:(BOOL)canEdit{
    self = [self initWithFrame:frame image:image title:nil canEidt:canEdit];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title canEidt:(BOOL)canEdit{
    self = [self initWithFrame:frame image:nil title:title canEidt:canEdit];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title hasTitleLine:(BOOL)hasTitleLine canEidt:(BOOL)canEdit{
    self = [self initWithFrame:frame image:nil title:title hasTitleLine:hasTitleLine canEidt:canEdit];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title canEidt:(BOOL)canEdit{
    if(title){
        self = [self initWithFrame:frame image:image title:title hasTitleLine:YES canEidt:canEdit];
    }
    else{
        self = [self initWithFrame:frame image:image title:title hasTitleLine:NO canEidt:canEdit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title hasTitleLine:(BOOL)hasTitleLine canEidt:(BOOL)canEdit{
    self = [super initWithFrame:frame];
    if (self) {
        _image = image;
        _title = title;
        _hasTitleLine = hasTitleLine;
        [self initSubView];
        [self addTap];
        self.contentTextField.userInteractionEnabled = canEdit;
    }
    return self;
}

- (void)initSubView{
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, [self frameHeight] - 1, [self frameWidth], 1)];
    _lineView.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3].CGColor;
    [self addSubview:_lineView];
    
    CGFloat titleWidth = 0;
    if (_image) {
        titleWidth = 40;
        int imageWidth = _image.size.width/_image.size.height * ([self frameHeight] - 9);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((titleWidth - imageWidth)/2, 0, imageWidth, [self frameHeight] - 9)];
        imageView.contentMode = 1;
        imageView.image = _image;
        [self addSubview:imageView];
    }
    if (_title) {
        CGFloat titleLabelWidth = 50;
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleWidth, 0, titleLabelWidth, [self frameHeight] - 9)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.text = _title;
        [self addSubview:_titleLabel];
        titleWidth += titleLabelWidth;
    }
    if (_hasTitleLine){
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(titleWidth+7, 0, 1, [self frameHeight] - 9)];
        lineView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
        [self addSubview:lineView];
        titleWidth += 14;
    }
    
    _contentTextField = [[UITextField alloc]initWithFrame:CGRectMake(titleWidth, 0, [self frameWidth] - titleWidth, [self frameHeight] - 9)];
    _contentTextField.placeholder = @"0";
    [_contentTextField setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forKeyPath:@"_placeholderLabel.textColor"];
    _contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    _contentTextField.tintColor = [UIColor whiteColor];
    _contentTextField.textColor = [UIColor whiteColor];
    _contentTextField.delegate = self;
    _contentTextField.textAlignment = NSTextAlignmentRight;
    [self addSubview:_contentTextField];
}

- (void)addTap{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBlockAction)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)clickBlockAction{
    if (_clickBlock) {
        _clickBlock();
    }
}

- (void)textFieldDidChoosed{
    _lineView.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
}

- (void)textFieldNotChoosed{
    _lineView.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3].CGColor;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _contentTextField) {
        [self textFieldDidChoosed];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == _contentTextField) {
        [self textFieldNotChoosed];
    }
    return YES;
}

@end
