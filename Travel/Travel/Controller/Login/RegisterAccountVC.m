//
//  RegisterAccountVC.m
//  FindDoctor
//
//  Created by 晓炜 郭 on 16/1/4.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "RegisterAccountVC.h"
#import "LoginTextFeildView.h"

#import "MBProgressHUD.h"
#import "TipHandler+HUD.h"
#import "AVOSCloud.h"
#import "AVUser.h"

#import "RegisterAddDetailsVC.h"
#import "UINavigationBar+Background.h"

#define kCodeButtonWith         80

@interface RegisterAccountVC (){
    UIButton *_codeButton;
    UILabel *_codeLabel;
    
    LoginTextFeildView *userTextFeildView;
    LoginTextFeildView *passwordTextFeildView;
    NSString *codetoken;
    int timerCount;
}

@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation RegisterAccountVC

- (instancetype)initWithPageName:(NSString *)pageName{
    self = [super initWithPageName:pageName];
    if (self) {
//        self.hasNavigationBar = NO;
    }
    return self;
}

- (void)viewDidLoad {
    self.title = @"验证手机号";
    [super viewDidLoad];
    [self.navigationBar useTranslucentBackgroundImage];
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"LoginOrRegisterVC_background"].CGImage;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdit)];
    [self.contentView addGestureRecognizer:tap];
    
    [self loadContens];
    // Do any additional setup after loading the view.
}

- (void)loadContens{
//    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    leftButton.backgroundColor = [UIColor clearColor];
//    leftButton.frame = CGRectMake(0, 0, 50, 50);
//    [leftButton setImage:[UIImage imageNamed:ImgStr_BackBtn] forState:UIControlStateNormal];
//    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
//    leftButton.tintColor = UIColorFromHex(Color_Hex_NavItem_Normal);
//    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 0);
//    [leftButton addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.contentView addSubview:leftButton];
    
    int intervalY = 30;
    int textFeildWidth = 280 , textFeildHeight = 30;
    
    UIImage *logoImage = [UIImage imageNamed:@"login_header_image"];
    UIView *logoImageView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - logoImage.size.width)/2, 1.2*intervalY , logoImage.size.width, logoImage.size.height)];
    logoImageView.layer.contents = (id)logoImage.CGImage;
    [self.contentView addSubview:logoImageView];
    
    userTextFeildView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, CGRectGetMaxY(logoImageView.frame) + intervalY, textFeildWidth, textFeildHeight) image:[UIImage imageNamed:@"login_icon_phone"]];
    userTextFeildView.contentTextField.placeholder = @"请输入手机号";
    [self.contentView addSubview:userTextFeildView];
    
    passwordTextFeildView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, CGRectGetMaxY(userTextFeildView.frame) + intervalY, textFeildWidth, textFeildHeight) image:[UIImage imageNamed:@"login_icon_code"]];
    passwordTextFeildView.contentTextField.placeholder = @"请输入验证码";
    [self.contentView addSubview:passwordTextFeildView];
    
    _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _codeButton.frame = CGRectMake(CGRectGetMaxX(passwordTextFeildView.frame) - kCodeButtonWith, CGRectGetMinY(passwordTextFeildView.frame), kCodeButtonWith, CGRectGetHeight(passwordTextFeildView.frame));
    [_codeButton setBackgroundImage:[UIImage imageNamed:@"login_code_bg"] forState:UIControlStateNormal];
    [_codeButton setBackgroundImage:[UIImage imageNamed:@"login_code_bg"] forState:UIControlStateDisabled];
    _codeButton.adjustsImageWhenHighlighted = NO;
    [_codeButton addTarget:self action:@selector(codeLableAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_codeButton];
    
    _codeLabel = [[UILabel alloc] initWithFrame:_codeButton.frame];
    _codeLabel.backgroundColor = [UIColor clearColor];
    _codeLabel.font = [UIFont systemFontOfSize:12];
    _codeLabel.textAlignment = NSTextAlignmentCenter;
    _codeLabel.textColor = [UIColor whiteColor];
    _codeLabel.text = @"获取验证码";
    [self.contentView addSubview:_codeLabel];
    
    UIButton *nextButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, CGRectGetMaxY(passwordTextFeildView.frame) + intervalY, textFeildWidth, 42)];
    nextButton.layer.backgroundColor = [UIColor clearColor].CGColor;
    nextButton.layer.cornerRadius = 21.f;
    nextButton.layer.borderColor = [UIColor whiteColor].CGColor;
    nextButton.layer.borderWidth = 1.f;
    [nextButton setTitle:@"下   一   步" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:nextButton];
}

- (void)codeLableAction
{
    [self endEdit];
    if ([userTextFeildView.contentTextField.text isEmpty])
    {
        [TipHandler showTipOnlyTextWithNsstring:@"请输入手机号"];
        return;
    }
    else{
        if (userTextFeildView.contentTextField.text.length != 11) {
            [TipHandler showTipOnlyTextWithNsstring:@"请输入正确的手机号"];
            return;
        }
        else{
            __weak __block typeof(self) blockSelf = self;
            [AVOSCloud requestSmsCodeWithPhoneNumber:userTextFeildView.contentTextField.text callback:^(BOOL succeeded, NSError *error) {
                if(succeeded){
                    [blockSelf startTimer];
                }
            }];
        }
    }
}

- (void)stopTimer
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)resetButton
{
    _codeLabel.text = @"获取验证码";
    _codeButton.enabled = YES;
    //    _codeField.text = @"";
}

- (void)startTimer {
    [self stopTimer];
    
    timerCount = 60;
    
    _codeButton.enabled = NO;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCode) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)updateCode
{
    if (timerCount < 0) {
        [self stopTimer];
        [self resetButton];
        return;
    }
    
    NSString *strTime = [NSString stringWithFormat:@"%.1d", timerCount];
    _codeLabel.text = [NSString stringWithFormat:@"%@s",strTime];
    
    timerCount--;
}

- (void)showHUD
{
    if (_hud == nil) {
        _hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _hud.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2);
        [self.view addSubview:_hud];
        [self.view bringSubviewToFront:_hud];
    }
    
    [_hud show:YES];
}

- (void)hideHUD
{
    [_hud hide:NO];
}
- (void)nextButtonAction{
    if ([passwordTextFeildView.contentTextField.text isEmpty]) {
        [TipHandler showTipOnlyTextWithNsstring:@"请输入验证码"];
        return;
    }
    else {
        __weak __block typeof(self) blockSelf = self;
        [AVOSCloud verifySmsCode:passwordTextFeildView.contentTextField.text mobilePhoneNumber:userTextFeildView.contentTextField.text callback:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                RegisterAddDetailsVC *vc = [[RegisterAddDetailsVC alloc]initWithPageName:NSStringFromClass([RegisterAddDetailsVC class])];
                XWUser *user = [XWUser user];
                user.mobilePhoneNumber = [userTextFeildView.contentTextField.text copy];
                vc.user = user;
                [blockSelf.slideNavigationController pushViewController:vc animated:YES];
            }
        }];
    }
}

- (void)endEdit{
    [self.contentView endEditing:YES];
//    [userTextFeildView.contentTextField resignFirstResponder];
//    [passwordTextFeildView.contentTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNavigationBar{
    [self addLeftBackButtonItemWithImage];
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
