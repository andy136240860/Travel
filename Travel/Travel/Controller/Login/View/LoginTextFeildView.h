//
//  LoginTextFeildView.h
//  FindDoctor
//
//  Created by 晓炜 郭 on 16/1/9.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock)(void);

@interface LoginTextFeildView : UIView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image canEidt:(BOOL)canEdit;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title canEidt:(BOOL)canEdit;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title hasTitleLine:(BOOL)hasTitleLine canEidt:(BOOL)canEdit;
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title canEidt:(BOOL)canEdit;
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title hasTitleLine:(BOOL)hasTitleLine canEidt:(BOOL)canEdit;

@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, copy)ClickBlock clickBlock;

- (void)textFieldDidChoosed;
- (void)textFieldNotChoosed;

@end
