//
//  LoginOrRegisterVC.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "LoginOrRegisterVC.h"
#import "UINavigationBar+Background.h"
#import "LoginVC.h"
#import "XWBannerView.h"

NSString *const wechatLoginButtonImageStr = @"wechatLoginButton";
NSString *const QQLoginButtonImageStr = @"QQLoginButton";
NSString *const weiboLoginButtonImageStr = @"weiboLoginButton";
NSString *const phoneLoginButtonImageStr = @"phoneLoginButton";

@interface LoginOrRegisterVC ()<XWBannerViewDelegate,XWBannerViewDataSource>

@property (nonatomic, strong) UIButton *wechatLoginButton;
@property (nonatomic, strong) UIButton *QQLoginButton;
@property (nonatomic, strong) UIButton *weiboLoginButton;
@property (nonatomic, strong) UIButton *phoneLoginButton;

@end

@implementation LoginOrRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents = (id)[UIImage imageNamed:@"LoginOrRegisterVC_background"].CGImage;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGFloat aminateDuration = 0.3;
    CGFloat damping = 1;
    CGFloat velocity = 8;
    //四个button的动画
    [UIView animateWithDuration:aminateDuration delay:0.5 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
        _wechatLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5, self.view.frameHeight - 129, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:aminateDuration delay:0.6 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
        _QQLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*2 + [_wechatLoginButton frameWidth], self.view.frameHeight - 129, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:aminateDuration delay:0.7 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
        _weiboLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*3 + [_wechatLoginButton frameWidth]*2, self.view.frameHeight - 129, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:aminateDuration delay:0.8 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
        _phoneLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*4 + [_wechatLoginButton frameWidth]*3, self.view.frameHeight - 129, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)loadContentView{
    XWBannerView *banner = [[XWBannerView alloc]init];
    banner.frame = CGRectMake(0 , (self.view.frameHeight - 480)/2.f + 10, [UIScreen mainScreen].bounds.size.width, 340);
    banner.delegate = self;
    banner.dataSource = self;
    banner.scrollTime = 5;
    banner.autoScroll = NO;
    banner.hasPageControl = YES;
    banner.translucent = YES;
    [self.view addSubview:banner];
    
    self.wechatLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5, self.view.frameHeight, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    self.QQLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*2 + [_wechatLoginButton frameWidth], self.view.frameHeight, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    self.weiboLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*3 + [_wechatLoginButton frameWidth]*2, self.view.frameHeight, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    self.phoneLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*4 + [_wechatLoginButton frameWidth]*3, self.view.frameHeight, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    [self.view addSubview:self.wechatLoginButton];
    [self.view addSubview:self.QQLoginButton];
    [self.view addSubview:self.weiboLoginButton];
    [self.view addSubview:self.phoneLoginButton];
    
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setTitle:@"随便看看" forState:UIControlStateNormal];
    cancelButton.layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [cancelButton sizeToFit];
    cancelButton.layer.cornerRadius = cancelButton.frameHeight/2.f;
    cancelButton.frame = CGRectMake((kScreenWidth - cancelButton.frameWidth - 14)/2.f, self.view.frameHeight - 35, cancelButton.frameWidth+14, cancelButton.frameHeight);
    [cancelButton addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfCellInView:(XWBannerView *)bannerView{
    return 5;
}

- (XWBannerViewCell *)XWBannerView:(XWBannerView *)bannerView cellForIndex:(NSInteger)index{
    XWBannerViewCell *cell = [[XWBannerViewCell alloc]initWithFrame:bannerView.bounds];
    cell.image = [UIImage imageNamed:@"loginBannerView"];
    cell.contentMode = 2;
    cell.clipsToBounds = YES;
    return cell;
}


#pragma mark 各种button
- (UIButton *)weiboLoginButton{
    if (_weiboLoginButton) {
        return _weiboLoginButton;
    }
    _weiboLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_weiboLoginButton setImage:[UIImage imageNamed:weiboLoginButtonImageStr] forState:UIControlStateNormal];
    [_weiboLoginButton sizeToFit];
    
    return _weiboLoginButton;
}

- (UIButton *)QQLoginButton{
    if (_QQLoginButton) {
        return _QQLoginButton;
    }
    _QQLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_QQLoginButton setImage:[UIImage imageNamed:QQLoginButtonImageStr] forState:UIControlStateNormal];
    [_QQLoginButton sizeToFit];
    
    return _QQLoginButton;
}

- (UIButton *)wechatLoginButton{
    if (_wechatLoginButton) {
        return _wechatLoginButton;
    }
    _wechatLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wechatLoginButton setImage:[UIImage imageNamed:wechatLoginButtonImageStr] forState:UIControlStateNormal];
    [_wechatLoginButton sizeToFit];
    
    return _wechatLoginButton;
}

- (UIButton *)phoneLoginButton{
    if (_phoneLoginButton) {
        return _phoneLoginButton;
    }
    _phoneLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneLoginButton setImage:[UIImage imageNamed:phoneLoginButtonImageStr] forState:UIControlStateNormal];
    [_phoneLoginButton sizeToFit];
    [_phoneLoginButton addTarget:self action:@selector(phoneLoginAction) forControlEvents:UIControlEventTouchUpInside];
    
    return _phoneLoginButton;
}

- (void)phoneLoginAction{
    LoginVC *vc = [[LoginVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelLogin{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
