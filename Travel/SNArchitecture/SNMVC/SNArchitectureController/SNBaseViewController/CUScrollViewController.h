//
//  CUScrollViewController.h
//  CollegeUnion
//
//  Created by li na on 15/3/7.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import "UIViewController+SNExtension.h"

@interface CUScrollViewController : UIViewController//<UIScrollViewDelegate>

//- (UIView *)contentView;

@property (nonatomic,strong,readonly) UIScrollView * contentView;
@property (strong,nonatomic)UIScrollView * scrollContentView;

- (void)loadNavigationBar;
- (void)loadContentView;

- (BOOL)pullUp;// 上拉
- (BOOL)pullDown;// 下拉
- (BOOL)pullDownToTop;

@end


@interface CUScrollViewController (keybord)

-(void)setViewMovedUp:(CGFloat)movedUpOffSet;


@end