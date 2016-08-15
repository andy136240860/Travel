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
    
    UIButton    *_myTravelButton;
}

@end

@implementation CollectionHeaderViewForMeVC

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, CollectionHeaderViewForMeVCHeight)];
    return self;
}

- (void)initSubView{
    CGFloat _avatarImageViewWidth = 90;
    
    _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 210)];
    _backgroundImageView.clipsToBounds = YES;
    _backgroundImageView.contentMode = 2;
    [self addSubview:_backgroundImageView];
    
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-_avatarImageViewWidth)/2.f, 136, _avatarImageViewWidth, _avatarImageViewWidth)];
    _avatarImageView.layer.cornerRadius = _avatarImageViewWidth/2.f;
    _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarImageView.layer.borderWidth = 2.f;
    _avatarImageView.clipsToBounds = YES;
    _avatarImageView.userInteractionEnabled = YES;
    [self addSubview:_avatarImageView];
    
    UITapGestureRecognizer *CollectionHeaderViewModel_userAvatar_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    CollectionHeaderViewModel_userAvatar_Tap.numberOfTapsRequired = 1;
    CollectionHeaderViewModel_userAvatar_Tap.numberOfTouchesRequired = 1;
    [_avatarImageView addGestureRecognizer:CollectionHeaderViewModel_userAvatar_Tap];
    CollectionHeaderViewModel_userAvatar_Tap.view.tag = CollectionHeaderViewModel_userAvatar;
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_avatarImageView.frame)+10, kScreenWidth, 17)];
    _nameLabel.font = [UIFont systemFontOfSize:17];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.userInteractionEnabled = YES;
    [self addSubview:_nameLabel];
    
    UITapGestureRecognizer *CollectionHeaderViewModel_userName_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    CollectionHeaderViewModel_userName_Tap.numberOfTapsRequired = 1;
    CollectionHeaderViewModel_userName_Tap.numberOfTouchesRequired = 1;
    [_nameLabel addGestureRecognizer:CollectionHeaderViewModel_userName_Tap];
    CollectionHeaderViewModel_userName_Tap.view.tag = CollectionHeaderViewModel_userName;
    
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake((kScreenWidth - 40*5)/6.f*(i+1)+40*i, CGRectGetMaxY(_nameLabel.frame)+20, 40, 40);
        button.tag = i+3;
        button.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                            saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                            brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                 alpha:1];
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)resetData{
    if ([[XWUser currentUser] isAuthenticated]) {
        _nameLabel.text = [XWUser currentUser].username;
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:[CUUserManager sharedInstance].user.icon] placeholderImage:[UIImage imageNamed:@"CollectionHeaderViewForMeVC_userAvatarDefaultImage"]];
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
