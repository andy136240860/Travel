//
//  CUViewController.m
//  CollegeUnion
//
//  Created by li na on 15/3/4.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import "CUViewController.h"
#import "CUUIContant.h"
#import "UIView+Extension.h"
#import "UIImage+Color.h"
#import "UIViewController+SNExtension.h"

@interface CUViewController ()

@property (nonatomic,strong) UIView * content;
@property (nonatomic,assign,readwrite)CGFloat keybordHeight;


@end

@implementation CUViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(IOS_7_0)) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:UIColorFromHex(Color_Hex_NavBackground)] forBarMetrics:UIBarMetricsDefault];
    
    //[self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"navigationbar_background_shadow"]];
    //[self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:UIColorFromHex(Color_Hex_NavShadow) size:CGSizeMake(kDefaultLintWidth,kDefaultLintWidth)]];
    
    self.keybordHeight = 220;
    self.view.backgroundColor = UIColorFromHex(Color_Hex_ContentViewBackground);
    
//    [self setShouldHaveTab];
    
    // --------------------如果有nav则重新生成一个可视的view,跟loadContentView的顺序不可以改
    [self addContentView];
    // --------------------子类执行以下方法
    [self loadNavigationBar];
    [self loadContentView];
}

- (void)removeContentView
{
    [self.content removeFromSuperview];
    self.content = nil;
}

- (void)setShouldHaveTab
{
}

- (void)addContentView
{
    self.content = [[UIView alloc] initWithFrame:self.view.bounds];
    self.content.frameHeight -= Height_NavigationBar;
    [self.view addSubview:self.content];
    self.content.backgroundColor = UIColorFromHex(Color_Hex_ContentViewBackground);
    if (self.hidesBottomBarWhenPushed)
    {
        self.content.frameHeight -= Height_Tabbar;
    }
}

- (UIView *)contentView
{
    if (self.content != nil)
    {
        return self.content;
    }
    return self.view;
}

- (void)loadNavigationBar
{
    // 去掉导航的阴影
//    self.navigationBar.shadowImage = [UIImage new];
}
- (void)loadContentView
{
    
}

@end




@implementation CUViewController (keybord)



-(void)setViewMovedUp:(CGFloat)movedUpOffSet
{
    CGRect rect = self.contentView.frame;
    if (rect.origin.y < 0)
    {
        return;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
   
    rect.origin.y -= movedUpOffSet;
    rect.size.height += movedUpOffSet;
    self.contentView.frame = rect;
    [UIView commitAnimations];
}


-(void)setViewMovedDown:(CGFloat)movedUpOffSet
{
    CGRect rect = self.contentView.frame;
    if (rect.origin.y > 0)
    {
        return;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    
    
    rect.origin.y += movedUpOffSet;
    rect.size.height -= movedUpOffSet;
    self.contentView.frame = rect;
    [UIView commitAnimations];
}


@end

