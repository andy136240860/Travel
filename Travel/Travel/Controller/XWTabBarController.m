//
//  XWTabBarController.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/17.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTabBarController.h"
#import "XWNavigationController.h"
#import "XWTabBar.h"

#import "MeViewController.h"
#import "HomeViewController.h"
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kOneUnitForPublish kScreenWidth/6.9282032302756f * 1.2

@interface XWTabBarController ()<XWTabBarDelegate>

@property (nonatomic, strong)UIVisualEffectView *effectView;
@property (nonatomic, strong)UIButton *button1_myTravel;
@property (nonatomic, strong)UIButton *button2_counselingRequest; //咨询请求
@property (nonatomic, strong)UIButton *button3_counseling; //咨询服务
@property (nonatomic, strong)UIButton *button4_travelTogether;
@property (nonatomic, strong)UIButton *button5_guide; //导游服务
@property (nonatomic, strong)UIButton *button6_guideRequest; //导游请求
@property (nonatomic, strong)UIButton *button7_camera;
@property (nonatomic, strong)UIButton *button8_close;

@end

@implementation XWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    HomeViewController *asdkHomeFeedVC      = [[HomeViewController alloc] init];
    UINavigationController *asdkHomeFeedNavCtrl  = [[UINavigationController alloc] initWithRootViewController:asdkHomeFeedVC];
    asdkHomeFeedNavCtrl.tabBarItem               = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_home_nor"] tag:0];
    asdkHomeFeedNavCtrl.hidesBarsOnSwipe         = YES;
    
    // ASDK Home Feed viewController & navController
    MeViewController *uikitHomeFeedVC     = [[MeViewController alloc] init];
    UINavigationController *uikitHomeFeedNavCtrl = [[UINavigationController alloc] initWithRootViewController:uikitHomeFeedVC];
    uikitHomeFeedNavCtrl.tabBarItem              = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_home_nor"] tag:1];
    
    // UITabBarController
    self.viewControllers             = @[uikitHomeFeedNavCtrl, asdkHomeFeedNavCtrl,uikitHomeFeedNavCtrl,uikitHomeFeedNavCtrl];
    self.selectedViewController      = asdkHomeFeedNavCtrl;
    [[UITabBar appearance] setTintColor:kGreenColor];
    
    XWTabBar *tabBar = [[XWTabBar alloc] init];
    tabBar.delegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */

#pragma ZTTabBarDelegate
/**
 *  加号按钮点击
 */
- (void)tabBarDidClickPlusButton:(XWTabBar *)tabBar
{
    [self effectViewWithTabBar:(XWTabBar *)tabBar].alpha = 0.f;
    [self.view addSubview:_effectView];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _effectView.alpha = 1.f;
    } completion:^(BOOL finished) {
    }];
    //我的旅程
    _button1_myTravel.frame = CGRectMake(kScreenWidth/2 - _button1_myTravel.currentBackgroundImage.size.width/2, kScreenHeight+ _button1_myTravel.currentBackgroundImage.size.height/2, _button1_myTravel.currentBackgroundImage.size.width, _button1_myTravel.currentBackgroundImage.size.height);
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _button1_myTravel.frame = CGRectMake(kScreenWidth/2 - _button1_myTravel.currentBackgroundImage.size.width/2, kScreenHeight/2 - 2*kOneUnitForPublish - _button1_myTravel.currentBackgroundImage.size.height/2, _button1_myTravel.currentBackgroundImage.size.width, _button1_myTravel.currentBackgroundImage.size.height);
    } completion:nil];
    //咨询请求
    _button2_counselingRequest.frame = CGRectMake(kScreenWidth/2 - kOneUnitForPublish*sqrt(3.f) - _button2_counselingRequest.currentBackgroundImage.size.width/2, kScreenHeight + _button2_counselingRequest.currentBackgroundImage.size.height/2, _button2_counselingRequest.currentBackgroundImage.size.width, _button2_counselingRequest.currentBackgroundImage.size.height);
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _button2_counselingRequest.frame = CGRectMake(kScreenWidth/2 - kOneUnitForPublish*sqrt(3.f) - _button2_counselingRequest.currentBackgroundImage.size.width/2, kScreenHeight/2 - kOneUnitForPublish - _button2_counselingRequest.currentBackgroundImage.size.height/2, _button2_counselingRequest.currentBackgroundImage.size.width, _button2_counselingRequest.currentBackgroundImage.size.height);
    } completion:nil];
    //咨询服务
    _button3_counseling.frame = CGRectMake(kScreenWidth/2 - kOneUnitForPublish*sqrt(3.f) - _button3_counseling.currentBackgroundImage.size.width/2, kScreenHeight + _button3_counseling.currentBackgroundImage.size.height/2, _button3_counseling.currentBackgroundImage.size.width, _button3_counseling.currentBackgroundImage.size.height);
    [UIView animateWithDuration:0.5 delay:0.6 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _button3_counseling.frame = CGRectMake(kScreenWidth/2 - kOneUnitForPublish*sqrt(3.f) - _button3_counseling.currentBackgroundImage.size.width/2, kScreenHeight/2 + kOneUnitForPublish - _button3_counseling.currentBackgroundImage.size.height/2, _button3_counseling.currentBackgroundImage.size.width, _button3_counseling.currentBackgroundImage.size.height);
    } completion:nil];
    //一起旅行
    _button4_travelTogether.frame = CGRectMake(kScreenWidth/2 - _button4_travelTogether.currentBackgroundImage.size.width/2, kScreenHeight + _button4_travelTogether.currentBackgroundImage.size.height/2, _button4_travelTogether.currentBackgroundImage.size.width, _button4_travelTogether.currentBackgroundImage.size.height);
    [UIView animateWithDuration:0.5 delay:0.8 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _button4_travelTogether.frame = CGRectMake(kScreenWidth/2 - _button4_travelTogether.currentBackgroundImage.size.width/2, kScreenHeight/2 + kOneUnitForPublish*2 - _button4_travelTogether.currentBackgroundImage.size.height/2, _button4_travelTogether.currentBackgroundImage.size.width, _button4_travelTogether.currentBackgroundImage.size.height);
    } completion:nil];
    //导游服务
    _button5_guide.frame = CGRectMake(kScreenWidth/2 + kOneUnitForPublish*sqrt(3.f) - _button5_guide.currentBackgroundImage.size.width/2, kScreenHeight + _button5_guide.currentBackgroundImage.size.height/2, _button5_guide.currentBackgroundImage.size.width, _button5_guide.currentBackgroundImage.size.height);
    [UIView animateWithDuration:0.5 delay:0.7 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _button5_guide.frame = CGRectMake(kScreenWidth/2 + kOneUnitForPublish*sqrt(3.f) - _button5_guide.currentBackgroundImage.size.width/2, kScreenHeight/2 + kOneUnitForPublish - _button5_guide.currentBackgroundImage.size.height/2, _button5_guide.currentBackgroundImage.size.width, _button5_guide.currentBackgroundImage.size.height);
    } completion:nil];
    //导游请求
    _button6_guideRequest.frame = CGRectMake(kScreenWidth/2 + kOneUnitForPublish*sqrt(3.f) - _button6_guideRequest.currentBackgroundImage.size.width/2, kScreenHeight + _button6_guideRequest.currentBackgroundImage.size.height/2, _button6_guideRequest.currentBackgroundImage.size.width, _button6_guideRequest.currentBackgroundImage.size.height);
    [UIView animateWithDuration:0.5 delay:0.4 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _button6_guideRequest.frame = CGRectMake(kScreenWidth/2 + kOneUnitForPublish*sqrt(3.f) - _button6_guideRequest.currentBackgroundImage.size.width/2, kScreenHeight/2 - kOneUnitForPublish - _button6_guideRequest.currentBackgroundImage.size.height/2, _button6_guideRequest.currentBackgroundImage.size.width, _button6_guideRequest.currentBackgroundImage.size.height);
    } completion:nil];
    //照相机
    _button7_camera.frame = CGRectMake(kScreenWidth/2 - _button7_camera.currentBackgroundImage.size.width/2, kScreenHeight + _button7_camera.currentBackgroundImage.size.height/2, _button7_camera.currentBackgroundImage.size.width, _button7_camera.currentBackgroundImage.size.height);
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _button7_camera.frame = CGRectMake(kScreenWidth/2 - _button7_camera.currentBackgroundImage.size.width/2, kScreenHeight/2 - _button7_camera.currentBackgroundImage.size.height/2, _button7_camera.currentBackgroundImage.size.width, _button7_camera.currentBackgroundImage.size.height);
    } completion:nil];
    //关闭publish按钮
    _button8_close.alpha = 0;
    [UIView animateWithDuration:0.8 delay:0.2 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _button8_close.alpha = 1;
    } completion:nil];
}

- (UIVisualEffectView *)effectViewWithTabBar:(XWTabBar *)tabBar{
    if (_effectView == nil) {
        _effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _effectView.frame = [UIScreen mainScreen].bounds;
        
        CGRect plusBtnFrame= [tabBar.plusBtn convertRect: tabBar.plusBtn.bounds toView:[[[UIApplication sharedApplication] delegate] window]];
        
        _button8_close = [[UIButton alloc]initWithFrame:plusBtnFrame];
        _button8_close.layer.cornerRadius = 32.f;
        _button8_close.clipsToBounds = YES;
        [_button8_close setBackgroundImage:[UIImage imageNamed:@"tabar_closeButton"] forState:UIControlStateNormal];
        [_button8_close addTarget:self action:@selector(closeEffectView) forControlEvents:UIControlEventTouchUpInside];
        [_effectView.contentView addSubview:self.button8_close];
        
        [_effectView.contentView addSubview:self.button1_myTravel];
        [_effectView.contentView addSubview:self.button2_counselingRequest];
        [_effectView.contentView addSubview:self.button3_counseling];
        [_effectView.contentView addSubview:self.button4_travelTogether];
        [_effectView.contentView addSubview:self.button5_guide];
        [_effectView.contentView addSubview:self.button6_guideRequest];
        [_effectView.contentView addSubview:self.button7_camera];
    }
    
    return _effectView;
}

- (UIButton *)button1_myTravel{
    if (_button1_myTravel == nil) {
        UIImage *image = [UIImage imageNamed:@"publish_tabButton_myTravel"];
        _button1_myTravel = [[UIButton alloc]init];
        [_button1_myTravel setBackgroundImage:image forState:UIControlStateNormal];
        [_button1_myTravel addTarget:self action:@selector(button1_myTravelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1_myTravel;
}

- (void)button1_myTravelAction{

}

- (UIButton *)button2_counselingRequest{
    if (_button2_counselingRequest == nil) {
        UIImage *image = [UIImage imageNamed:@"publish_tabButton_counselingRequest"];
        _button2_counselingRequest = [[UIButton alloc]init];
        [_button2_counselingRequest setBackgroundImage:image forState:UIControlStateNormal];
        [_button2_counselingRequest addTarget:self action:@selector(button2_counselingRequestAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2_counselingRequest;
}

- (void)button2_counselingRequestAction{
    
}

- (UIButton *)button3_counseling{
    if (_button3_counseling == nil) {
        UIImage *image = [UIImage imageNamed:@"publish_tabButton_counseling"];
        _button3_counseling = [[UIButton alloc]init];
        [_button3_counseling setBackgroundImage:image forState:UIControlStateNormal];
        [_button3_counseling addTarget:self action:@selector(button3_counselingAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3_counseling;
}

- (void)button3_counselingAction{
    
}

- (UIButton *)button4_travelTogether{
    if (_button4_travelTogether == nil) {
        UIImage *image = [UIImage imageNamed:@"publish_tabButton_travelTogether"];
        _button4_travelTogether = [[UIButton alloc]init];
        [_button4_travelTogether setBackgroundImage:image forState:UIControlStateNormal];
        [_button4_travelTogether addTarget:self action:@selector(button4_travelTogetherAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button4_travelTogether;
}

- (void)button4_travelTogetherAction{
    
}

- (UIButton *)button5_guide{
    if (_button5_guide == nil) {
        UIImage *image = [UIImage imageNamed:@"publish_tabButton_guide"];
        _button5_guide = [[UIButton alloc]init];
        [_button5_guide setBackgroundImage:image forState:UIControlStateNormal];
        [_button5_guide addTarget:self action:@selector(button5_guideAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button5_guide;
}

- (void)button5_guideAction{
    
}

- (UIButton *)button6_guideRequest{
    if (_button6_guideRequest == nil) {
        UIImage *image = [UIImage imageNamed:@"publish_tabButton_guideRequest"];
        _button6_guideRequest = [[UIButton alloc]init];
        [_button6_guideRequest setBackgroundImage:image forState:UIControlStateNormal];
        [_button6_guideRequest addTarget:self action:@selector(button6_guideRequestAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button6_guideRequest;
}

- (void)button6_guideRequestAction{
    
}

- (UIButton *)button7_camera{
    if (_button7_camera == nil) {
        UIImage *image = [UIImage imageNamed:@"publish_tabButton_camera"];
        _button7_camera = [[UIButton alloc]init];
        [_button7_camera setBackgroundImage:image forState:UIControlStateNormal];
        [_button7_camera addTarget:self action:@selector(button7_cameraAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button7_camera;
}

- (void)button7_cameraAction{
    
}

- (void)closeEffectView{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.effectView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.effectView removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
