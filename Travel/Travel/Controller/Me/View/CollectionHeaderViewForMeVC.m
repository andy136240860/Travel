//
//  CollectionHeaderViewForMeVC.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/1.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "CollectionHeaderViewForMeVC.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "CUUserManager.h"
#import "XWUser.h"

@interface  CollectionHeaderViewForMeVC(){
    UIImageView *_backgroundImageView;
    UIImageView *_avatarImageView;
    UILabel     *_nameLabel;
    
    UIView      *_buttonsBackgroundView;
    UIButton    *_myTravelButton;
}

@end

@implementation CollectionHeaderViewForMeVC

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kTableViewGrayColor;
        [self initSubView];
    }
    return self;
}

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, CollectionHeaderViewForMeVCHeight)];
    return self;
}

- (void)initSubView{
    CGFloat _avatarImageViewWidth = 72;
    
    _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 508/2.f)];
    _backgroundImageView.clipsToBounds = YES;
    _backgroundImageView.contentMode = 2;
    _backgroundImageView.userInteractionEnabled = YES;
    _backgroundImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backgroundImageView];
    
    UIView *blackTranslucentView = [[UIView alloc]initWithFrame:_backgroundImageView.bounds];
    blackTranslucentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [_backgroundImageView addSubview:blackTranslucentView];
    
    UITapGestureRecognizer *CollectionHeaderViewModel_myCollectionHeaderViewBackgrondImage_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    CollectionHeaderViewModel_myCollectionHeaderViewBackgrondImage_Tap.numberOfTapsRequired = 1;
    CollectionHeaderViewModel_myCollectionHeaderViewBackgrondImage_Tap.numberOfTouchesRequired = 1;
    [_backgroundImageView addGestureRecognizer:CollectionHeaderViewModel_myCollectionHeaderViewBackgrondImage_Tap];
    CollectionHeaderViewModel_myCollectionHeaderViewBackgrondImage_Tap.view.tag = CollectionHeaderViewModel_myCollectionHeaderViewBackgrondImage;
    
    UIView *_avatarImageViewBGView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-_avatarImageViewWidth - 6)/2.f, 54, _avatarImageViewWidth + 6, _avatarImageViewWidth + 6)];
    _avatarImageViewBGView.layer.cornerRadius = (_avatarImageViewWidth + 6)/2.f;
    _avatarImageViewBGView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    _avatarImageViewBGView.clipsToBounds = YES;
    [_backgroundImageView addSubview:_avatarImageViewBGView];
    
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, _avatarImageViewWidth, _avatarImageViewWidth)];
    _avatarImageView.layer.cornerRadius = _avatarImageViewWidth/2.f;
    _avatarImageView.clipsToBounds = YES;
    _avatarImageView.userInteractionEnabled = YES;
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_avatarImageViewBGView addSubview:_avatarImageView];
    
    UITapGestureRecognizer *CollectionHeaderViewModel_userAvatar_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    CollectionHeaderViewModel_userAvatar_Tap.numberOfTapsRequired = 1;
    CollectionHeaderViewModel_userAvatar_Tap.numberOfTouchesRequired = 1;
    [_avatarImageView addGestureRecognizer:CollectionHeaderViewModel_userAvatar_Tap];
    CollectionHeaderViewModel_userAvatar_Tap.view.tag = CollectionHeaderViewModel_userAvatar;
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_avatarImageViewBGView.frame)+15, kScreenWidth, 17)];
    _nameLabel.font = [UIFont systemFontOfSize:17];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.userInteractionEnabled = YES;
    [_backgroundImageView addSubview:_nameLabel];
    
    UITapGestureRecognizer *CollectionHeaderViewModel_userName_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    CollectionHeaderViewModel_userName_Tap.numberOfTapsRequired = 1;
    CollectionHeaderViewModel_userName_Tap.numberOfTouchesRequired = 1;
    [_nameLabel addGestureRecognizer:CollectionHeaderViewModel_userName_Tap];
    CollectionHeaderViewModel_userName_Tap.view.tag = CollectionHeaderViewModel_userName;
    
    UIButton *settingButton = [[UIButton alloc]initWithFrame:CGRectMake(_avatarImageViewBGView.frameX - 40 - 50, _avatarImageViewBGView.centerY - 25, 50, 50)];
    [settingButton setImage:[UIImage imageNamed:@"commen_settingButton"] forState:UIControlStateNormal];
    settingButton.tag = CollectionHeaderViewModel_setting;
    [settingButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImageView addSubview:settingButton];
    
    UIButton *inboxButton = [[UIButton alloc]initWithFrame:CGRectMake(_avatarImageViewBGView.maxX + 40, _avatarImageViewBGView.centerY - 25, 50, 50)];
    [inboxButton setImage:[UIImage imageNamed:@"commen_settingButton"] forState:UIControlStateNormal];
    inboxButton.tag = CollectionHeaderViewModel_inbox;
    [inboxButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImageView addSubview:inboxButton];
    
    _buttonsBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, _backgroundImageView.maxY + kBlockIntervalY, kScreenWidth, 80)];
    _buttonsBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_buttonsBackgroundView];
    
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake((kScreenWidth - 40*5)/6.f*(i+1)+40*i, 20, 40, 40);
        button.tag = i+3;
        button.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                            saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                            brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                 alpha:1];
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonsBackgroundView addSubview:button];
    }
}

- (void)resetData{
    if ([[XWUser currentUser] isAuthenticated]) {
        _nameLabel.text = [XWUser currentUser].username;
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:[XWUser currentUser].avatarURL] placeholderImage:[UIImage imageNamed:@"CollectionHeaderViewForMeVC_userAvatarDefaultImage"]];
        [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:[XWUser currentUser].mySpaceBackgroundImageURL] placeholderImage:[UIImage imageNamed:@"CollectionHeaderViewForMeVC_backgrounddefaultImage"]];
    }
    else{
        [_avatarImageView setImage:[UIImage imageNamed:@"CollectionHeaderViewForMeVC_userAvatarDefaultImage"]];
        [_backgroundImageView setImage:[UIImage imageNamed:@"CollectionHeaderViewForMeVC_backgrounddefaultImage"]];
        _nameLabel.text = @"未登录";
    }
}

- (void)tapAction:(id)sender{
    if([self.delegate respondsToSelector:@selector(clickButtonActionWithModel:)]){
        if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer *tap = sender;
            NSInteger clickTag = tap.view.tag;
            [self.delegate clickButtonActionWithModel:clickTag];
        }
        if ([sender isKindOfClass:[UIButton class]]) {
            UIButton *button = sender;
            NSInteger clickTag = button.tag;
            [self.delegate clickButtonActionWithModel:clickTag];
        }
    }
}
@end
