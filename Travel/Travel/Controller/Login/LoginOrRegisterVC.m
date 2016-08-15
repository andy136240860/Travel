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
    [self.navigationBar useTranslucentBackgroundImage];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGFloat aminateDuration = 0.3;
    CGFloat damping = 1;
    CGFloat velocity = 8;
    //四个button的动画
    [UIView animateWithDuration:aminateDuration delay:0.5 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
        _wechatLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5, self.contentView.frameHeight - 129, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:aminateDuration delay:0.6 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
        _QQLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*2 + [_wechatLoginButton frameWidth], self.contentView.frameHeight - 129, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:aminateDuration delay:0.7 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
        _weiboLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*3 + [_wechatLoginButton frameWidth]*2, self.contentView.frameHeight - 129, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:aminateDuration delay:0.8 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
        _phoneLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*4 + [_wechatLoginButton frameWidth]*3, self.contentView.frameHeight - 129, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
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
    
    self.wechatLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5, self.contentView.frameHeight, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    self.QQLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*2 + [_wechatLoginButton frameWidth], self.contentView.frameHeight, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    self.weiboLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*3 + [_wechatLoginButton frameWidth]*2, self.contentView.frameHeight, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    self.phoneLoginButton.frame = CGRectMake((kScreenWidth - [_wechatLoginButton frameWidth]*4)/5*4 + [_wechatLoginButton frameWidth]*3, self.contentView.frameHeight, [_wechatLoginButton frameWidth], [_wechatLoginButton frameHeight]);
    [self.contentView addSubview:self.wechatLoginButton];
    [self.contentView addSubview:self.QQLoginButton];
    [self.contentView addSubview:self.weiboLoginButton];
    [self.contentView addSubview:self.phoneLoginButton];
    
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setTitle:@"随便看看" forState:UIControlStateNormal];
    cancelButton.layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [cancelButton sizeToFit];
    cancelButton.layer.cornerRadius = cancelButton.frameHeight/2.f;
    cancelButton.frame = CGRectMake((kScreenWidth - cancelButton.frameWidth - 14)/2.f, self.contentView.frameHeight - 35, cancelButton.frameWidth+14, cancelButton.frameHeight);
    [cancelButton addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelButton];
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
    LoginVC *vc = [[LoginVC alloc]initWithPageName:NSStringFromClass([LoginVC class])];
    [self.slideNavigationController pushViewController:vc animated:YES];
}

- (void)cancelLogin{
    [self.slideNavigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//- (void)loadNavigationBar{
//    [[self addLeftCloseButtonItemWithImage] addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (UIView *)loginView{
//    if (_loginView) {
//        return _loginView;
//    }
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.frameHeight - 50, kScreenWidth, 50)];
//    view.userInteractionEnabled = YES;
//    view.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
//
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
//    lineView.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4].CGColor;
//    [view addSubview:lineView];
//
//    UILabel *label = [[UILabel alloc]init];
//    label.text = @"已经有账户了？登录。";
//    label.font = [UIFont systemFontOfSize:12];
//    label.textColor = [UIColor whiteColor];
//    [label sizeToFit];
//    label.frame = CGRectMake((kScreenWidth - label.frameWidth)/2, (view.frameHeight - label.frameHeight)/2, label.frameWidth, label.frameHeight);
//    [view addSubview:label];
//
//    UITapGestureRecognizer *loginTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginAction)];
//    loginTap.numberOfTapsRequired = 1;
//    loginTap.numberOfTouchesRequired = 1;
//    [view addGestureRecognizer:loginTap];
//    _loginView = view;
//    return _loginView;
//}

@end
