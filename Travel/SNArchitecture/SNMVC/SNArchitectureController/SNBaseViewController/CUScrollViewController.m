//
//  CUScrollViewController.m
//  CollegeUnion
//
//  Created by li na on 15/3/7.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import "CUScrollViewController.h"
#import "CUUIContant.h"
#import "UIView+Extension.h"
#import "UIImage+Color.h"


@interface CUScrollViewController ()

@property (nonatomic,assign)CGPoint tempContentOffset;

@end

@implementation CUScrollViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    ImgStr_BackBtn = @"navbar_back_button";
//    Color_Hex_NavText_Normal = Color_Hex_Text_Normal;
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromHex(Color_Hex_ContentViewBackground);
    
    // --------------------如果有nav则重新生成一个可视的view,跟loadContentView的顺序不可以改
    [self addScrollContentView];
    // --------------------子类执行以下方法
    [self loadNavigationBar];
    [self loadContentView];
}

- (void)loadNavigationBar
{
    // 去掉导航的阴影
//    self.navigationBar.shadowImage = [UIImage new];
}

- (instancetype)initWithPageName:(NSString *)pageName
{
    if (self = [super init])
    {
        self.pageName = pageName;
    }
    return self;
    
}

- (void)loadContentView
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#warning TODO
- (void)addScrollContentView
{
    self.scrollContentView = [UIScrollView newAutoLayoutView];
    self.scrollContentView.backgroundColor = UIColorFromHex(Color_Hex_ContentViewBackground);
    [self.view addSubview:self.scrollContentView];
}

//- (void)addScrollContentView
//{
//    self.scrollContentView = [[UIScrollView alloc] init];
//    [self.view addSubview:self.scrollContentView];
//    self.scrollContentView.frame = [self subviewFrame];
//    self.scrollContentView.backgroundColor = UIColorFromHex(Color_Hex_ContentViewBackground);
//    
//     if (self.hasTab)
//    {
//        self.scrollContentView.frameHeight -= Height_Tabbar;
//    }
//    
//    self.scrollContentView.showsVerticalScrollIndicator = NO;
//    self.scrollContentView.showsHorizontalScrollIndicator = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    CGSize newSize = CGSizeMake(self.scrollContentView.frameWidth, self.scrollContentView.frameHeight);
//    [self.scrollContentView setContentSize:newSize];
//    
//}

- (UIScrollView *)contentView
{
    return self.scrollContentView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)pullDownToTop
{
    BOOL down = NO;
    CGPoint offset1 = self.scrollContentView.contentOffset;
    CGRect bounds1 = self.scrollContentView.bounds;
    //    CGSize size1 = self.scrollContentView.contentSize;
    UIEdgeInsets inset1 = self.scrollContentView.contentInset;
    float y1 = offset1.y + bounds1.size.height - inset1.bottom;
    //    float h1 = size1.height;
    if (y1 < self.scrollContentView.frame.size.height && offset1.y < 0)
    {
        down = YES;
    }
    return down;
    
}


- (BOOL)pullUp
{
    BOOL up = NO;
    CGPoint offset1 = self.scrollContentView.contentOffset;
    CGRect bounds1 = self.scrollContentView.bounds;
//    CGSize size1 = self.scrollContentView.contentSize;
    UIEdgeInsets inset1 = self.scrollContentView.contentInset;
    float y1 = offset1.y + bounds1.size.height - inset1.bottom;
//    float h1 = size1.height;
    if (y1 > self.scrollContentView.frame.size.height)
    {
        up = YES;
    }
    return up;
    
}
- (BOOL)pullDown
{
    BOOL down = NO;
    CGPoint offset1 = self.scrollContentView.contentOffset;
    CGRect bounds1 = self.scrollContentView.bounds;
//    CGSize size1 = self.scrollContentView.contentSize;
    UIEdgeInsets inset1 = self.scrollContentView.contentInset;
    float y1 = offset1.y + bounds1.size.height - inset1.bottom;
//    float h1 = size1.height;
    if (y1 < self.scrollContentView.frame.size.height)
    {
        down = YES;
    }
    return down;
}


@end



@implementation CUScrollViewController (keybord)

-(void)setViewMovedUp:(CGFloat)movedUpOffSet
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.contentView.frame;
    
    rect.origin.y -= movedUpOffSet;
    rect.size.height += movedUpOffSet;
    self.contentView.frame = rect;
    [UIView commitAnimations];
}

@end

