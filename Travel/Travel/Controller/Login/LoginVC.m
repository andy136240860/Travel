
//
//  LoginVC.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "LoginVC.h"
#import "LoginTextFeildView.h"
#import "RegisterAccountVC.h"
#import "LoginOrRegisterVC.h"
#import "LjjUISegmentedControl.h"
#import "XWUser.h"
#import "UIViewController+TSMessageHandler.h"
#import "XWNavigationController.h"
#import "UIViewController+NavBarTool.h"

@interface LoginVC ()<LjjUISegmentedControlDelegate,UITextFieldDelegate>{
    UIView             *phoneLoginView;
    LoginTextFeildView *countryChooesView;
    LoginTextFeildView *phoneNumberTextFeildView;
    LoginTextFeildView *phonePasswordTextFeildView;
    UIView             *userNameLoginView;
    LoginTextFeildView *userNameTextFeildView;
    LoginTextFeildView *userPasswordTextFeildView;
    
    UIButton *nextButton;
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.layer.contents = (id)[UIImage imageNamed:@"LoginOrRegisterVC_background"].CGImage;
    
    [self useTranslucentBackgroundImage];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self addRightButtonWithTitle:@"注册" seletor:@selector(registerAccountAction)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)loadContentView{
    int intervalY = 30;
    int textFeildWidth = 280 , textFeildHeight = 30;
    
    LjjUISegmentedControl* ljjuisement=[[LjjUISegmentedControl alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 220)/2.f, intervalY + kNavigationHeight, 220, LjjUISegmentedControlDefaultHeight)];
    NSArray* ljjarray=[NSArray arrayWithObjects:@"手机号登录",@"用户名登录",nil];
    ljjuisement.delegate = self;
    [ljjuisement AddSegumentArray:ljjarray];
    [self.view addSubview:ljjuisement];
    
    phoneLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(ljjuisement.frame), kScreenWidth, 300)];
    [self.view addSubview:phoneLoginView];
    
    countryChooesView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2,  intervalY, textFeildWidth, textFeildHeight) title:@"国家" hasTitleLine:NO canEidt:NO];
    countryChooesView.contentTextField.text = @">";
    countryChooesView.clickBlock = ^{
        NSLog(@"选择国家");
    };
    [phoneLoginView addSubview:countryChooesView];
    
    phoneNumberTextFeildView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2,  CGRectGetMaxY(countryChooesView.frame) + intervalY, textFeildWidth, textFeildHeight) title:@"+86" canEidt:YES];
    phoneNumberTextFeildView.contentTextField.placeholder = @"手机号";
    phoneNumberTextFeildView.contentTextField.keyboardType = UIKeyboardTypeDefault;
    phoneNumberTextFeildView.contentTextField.delegate = self;
    [phoneLoginView addSubview:phoneNumberTextFeildView];
    
    phonePasswordTextFeildView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, CGRectGetMaxY(phoneNumberTextFeildView.frame) + intervalY, textFeildWidth, textFeildHeight) image:[UIImage imageNamed:@"login_icon_code"]];
    phonePasswordTextFeildView.contentTextField.placeholder = @"密码";
    phonePasswordTextFeildView.contentTextField.keyboardType = UIKeyboardTypeDefault;
    phonePasswordTextFeildView.contentTextField.delegate = self;
    phonePasswordTextFeildView.contentTextField.secureTextEntry = YES;
    [phoneLoginView addSubview:phonePasswordTextFeildView];
    
    userNameLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(ljjuisement.frame), kScreenWidth, 300)];
    [self.view addSubview:userNameLoginView];
    userNameLoginView.hidden = YES;
    
    userNameTextFeildView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2,  intervalY, textFeildWidth, textFeildHeight) image:[UIImage imageNamed:@"login_icon_phone"]];
    userNameTextFeildView.contentTextField.placeholder = @"用户名";
    userNameTextFeildView.contentTextField.keyboardType = UIKeyboardTypeDefault;
    userNameTextFeildView.contentTextField.delegate = self;
    [userNameLoginView addSubview:userNameTextFeildView];
    
    userPasswordTextFeildView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, CGRectGetMaxY(userNameTextFeildView.frame) + intervalY, textFeildWidth, textFeildHeight) image:[UIImage imageNamed:@"login_icon_code"]];
    userPasswordTextFeildView.contentTextField.placeholder = @"密码";
    userPasswordTextFeildView.contentTextField.keyboardType = UIKeyboardTypeDefault;
    userPasswordTextFeildView.contentTextField.delegate = self;
    userPasswordTextFeildView.contentTextField.secureTextEntry = YES;
    [userNameLoginView addSubview:userPasswordTextFeildView];
    
    nextButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, kScreenHeight - 120 - kNavigationHeight, textFeildWidth, 42)];
    nextButton.layer.backgroundColor = [UIColor clearColor].CGColor;
    nextButton.layer.cornerRadius = 21.f;
    nextButton.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3].CGColor;
    nextButton.layer.borderWidth = 1.f;
    [nextButton setTitle:@"登        录" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
    nextButton.userInteractionEnabled = NO;
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

- (void)makeButtonUserInteractionEnabled:(BOOL)canClicked{
    if (canClicked) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
            nextButton.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
            [nextButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            nextButton.userInteractionEnabled = YES;
        }];
    }
    else{
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
            nextButton.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3].CGColor;
            [nextButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3] forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            nextButton.userInteractionEnabled = NO;
        }];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self verifyTextField];
    if (textField == phoneNumberTextFeildView.contentTextField) {
        if (string.length > 15) return NO;
    }
    
    return YES;
}

- (void)verifyTextField{
    if (phoneLoginView.hidden == NO) {
        if ([phoneNumberTextFeildView.contentTextField.text isEmpty]||[phonePasswordTextFeildView.contentTextField.text isEmpty]) {
            [self makeButtonUserInteractionEnabled:NO];
        }
        else{
            [self makeButtonUserInteractionEnabled:YES];
        }
    }
    if (userNameLoginView.hidden == NO) {
        if ([userNameTextFeildView.contentTextField.text isEmpty]||[userPasswordTextFeildView.contentTextField.text isEmpty]) {
            [self makeButtonUserInteractionEnabled:NO];
        }
        else{
            [self makeButtonUserInteractionEnabled:YES];
        }
    }
}

- (void)uisegumentSelectionChange:(NSInteger)selection{
    switch (selection) {
        case 0:{
            phoneLoginView.hidden = NO;
            userNameLoginView.hidden = YES;
        }
            break;
        case 1:{
            phoneLoginView.hidden = YES;
            userNameLoginView.hidden = NO;
        }
            break;
            
        default:
            break;
    }
    [self verifyTextField];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    id view = [textField superview];
    if ([view isKindOfClass:[LoginTextFeildView class]]) {
        LoginTextFeildView *viewVerifyed = view;
        [viewVerifyed textFieldDidChoosed];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    id view = [textField superview];
    if ([view isKindOfClass:[LoginTextFeildView class]]) {
        LoginTextFeildView *viewVerifyed = view;
        [viewVerifyed textFieldNotChoosed];
    }
    [self verifyTextField];
    return YES;
}

- (void)nextButtonAction{
    if (phoneLoginView.hidden == NO){
        [XWUser logInWithMobilePhoneNumberInBackground:phoneNumberTextFeildView.contentTextField.text password:phonePasswordTextFeildView.contentTextField.text block:^(AVUser *user, NSError *error) {
            if (user != nil) {
                XWUser *myUser = [XWUser currentUser];
                myUser.avatarURL = [user objectForKey:@"avatarURL"];
                myUser.nickName = [user objectForKey:@"nickName"];
                [self showMessageWithTitle:@"登录成功" subTitle:nil type:TSMessageNotificationTypeSuccess];
                [self performSelector:@selector(dismissView) withObject:self afterDelay:1];
            } else {
                [self showMessageWithTitle:@"登录失败" subTitle:[error.userInfo objectForKey:@"NSLocalizedDescription"] type:TSMessageNotificationTypeError];
            }
        }];
    }
    if (userNameLoginView.hidden == NO) {
        [XWUser logInWithUsernameInBackground:userNameTextFeildView.contentTextField.text password:userPasswordTextFeildView.contentTextField.text block:^(AVUser *user, NSError *error) {
            XWUser *myUser = [XWUser currentUser];
            myUser.avatarURL = [user objectForKey:@"avatarURL"];
            myUser.nickName = [user objectForKey:@"nickName"];
            if (user != nil) {
                [self showMessageWithTitle:@"登录成功" subTitle:nil type:TSMessageNotificationTypeSuccess];
                [self performSelector:@selector(dismissView) withObject:self afterDelay:1];
            } else {
                [self showMessageWithTitle:@"登录失败" subTitle:[error.userInfo objectForKey:@"NSLocalizedDescription"] type:TSMessageNotificationTypeError];
            }
        }];
    }
}

- (void)dismissView{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)loadNavigationBar{
//    [self addLeftBackButtonItemWithImage];
//    [self addRightButtonItemWithTitle:@"注册" target:self action:@selector(registerAccountAction)];
//}

- (void)registerAccountAction{
     UINavigationController *slide = self.navigationController;
//    UIViewController *vc = nil;
//    for (UIViewController *controller in slide.viewControllers) {
//        if ([controller isKindOfClass:[LoginOrRegisterVC class]]) {
//            vc = controller;
//            break;
//        }
//    }
//    if (vc) {
//        [slide popToViewController:vc animated:NO];
//    }
//    
    RegisterAccountVC *pushvc = [[RegisterAccountVC alloc]init];
    [slide pushViewController:pushvc animated:YES];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
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
