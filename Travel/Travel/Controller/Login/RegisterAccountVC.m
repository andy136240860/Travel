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
#import "CUViewController+TSMessageHandler.h"
#import "AVOSCloud.h"
#import "AVUser.h"

#import "RegisterAddDetailsVC.h"
#import "UINavigationBar+Background.h"

#import "TSMessage.h"

#define kCodeButtonWith         80

@interface RegisterAccountVC (){
    UIButton *_codeButton;
    UILabel *_codeLabel;
    
    LoginTextFeildView *countryChooesView;
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

    
    int intervalY = 30;
    int textFeildWidth = 280 , textFeildHeight = 30;
    
    UIImage *logoImage = [UIImage imageNamed:@"login_header_image"];
    UIView *logoImageView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - logoImage.size.width)/2, 1.2*intervalY , logoImage.size.width, logoImage.size.height)];
    logoImageView.layer.contents = (id)logoImage.CGImage;
    [self.contentView addSubview:logoImageView];
    
    countryChooesView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2,  intervalY, textFeildWidth, textFeildHeight) title:@"国家" hasTitleLine:NO canEidt:NO];
    countryChooesView.contentTextField.text = @">";
    countryChooesView.clickBlock = ^{
        NSLog(@"选择国家");
    };
    [self.contentView addSubview:countryChooesView];
    
    userTextFeildView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2,  CGRectGetMaxY(countryChooesView.frame) + intervalY, textFeildWidth, textFeildHeight) title:@"+86" canEidt:YES];
    userTextFeildView.contentTextField.placeholder = @"手机号";
    userTextFeildView.contentTextField.keyboardType = UIKeyboardTypeDefault;
    [self.contentView addSubview:userTextFeildView];
    
    passwordTextFeildView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, CGRectGetMaxY(userTextFeildView.frame) + intervalY, textFeildWidth, textFeildHeight) image:nil];
    passwordTextFeildView.contentTextField.placeholder = @"短信验证码";
    passwordTextFeildView.contentTextField.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:passwordTextFeildView];
    
    _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _codeButton.frame = CGRectMake(CGRectGetMaxX(passwordTextFeildView.frame) - kCodeButtonWith, CGRectGetMinY(passwordTextFeildView.frame)-3, kCodeButtonWith, textFeildHeight);
    _codeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _codeButton.layer.borderWidth = 0.5f;
    _codeButton.layer.cornerRadius = 3;
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
    
    UIButton *nextButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, kScreenHeight - 120 - kNavigationHeight, textFeildWidth, 42)];
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
        [self showMessageWithTitle:@"请输入手机号" type:TSMessageNotificationTypeWarning];
        return;
    }
    else{
        if (userTextFeildView.contentTextField.text.length != 11) {
            [self showMessageWithTitle:@"请输入正确的手机号" type:TSMessageNotificationTypeWarning];
            return;
        }
        else{
            __weak __block typeof(self) blockSelf = self;
            [self showHUD];
            [AVOSCloud requestSmsCodeWithPhoneNumber:userTextFeildView.contentTextField.text callback:^(BOOL succeeded, NSError *error) {
                [blockSelf hideHUD];
                if(succeeded){
                    [blockSelf startTimer];
                }
                else{
                    [self showMessageWithTitle:@"发送验证码失败" subTitle:[error.userInfo objectForKey:@"NSLocalizedDescription"] type:TSMessageNotificationTypeError];
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
    _codeLabel.textColor = [UIColor whiteColor];
    _codeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _codeButton.userInteractionEnabled = YES;
    //    _codeField.text = @"";
}

- (void)startTimer {
    [self stopTimer];
    
    timerCount = 60;
    
    _codeButton.userInteractionEnabled = NO;
    _codeLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    _codeButton.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3].CGColor;
    
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
        [self showMessageWithTitle:@"请输入验证码" type:TSMessageNotificationTypeWarning];
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
            else{
                [self showErrorWithTitle:@"获取验证码失败"];
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
