//
//  XWViewController.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/17.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWViewController.h"
#import "EditTravelTogetherHeaderView.h"

@interface XWViewController ()

@property (nonatomic,strong) UIView * content;

@end

@implementation XWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addContentView];
    [self loadContentView];
    [self useDefaultNavBarTitleColor];
    [self useDefaultNavBarBackgroudColor];
}

- (UIView *)contentView
{
    if (self.content != nil)
    {
        return self.content;
    }
    return self.view;
}

- (void)addContentView
{
    self.content = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    self.content.frameHeight -= Height_NavigationBar;
    [self.view addSubview:self.content];
//    self.content.backgroundColor = UIColorFromHex(Color_Hex_ContentViewBackground);
    if (!self.hidesBottomBarWhenPushed)
    {
        self.content.frameHeight -= Height_Tabbar;
    }
}

- (void)loadContentView {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (UIViewController*) topMostController {
    UIViewController *topController = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

+ (UIViewController*)currentViewController {
    UIViewController *currentViewController = [[self class] topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
