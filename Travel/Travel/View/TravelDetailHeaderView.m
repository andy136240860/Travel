//
//  TravelDetailHeaderView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/9.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "TravelDetailHeaderView.h"
#import "UIImageView+WebCache.h"

@interface TravelDetailHeaderView() {
    UIImageView *backgroundImageView;
    UIImageView *avatarImageView;
    UILabel     *titleLabel;
    UILabel     *subTitleLabel;
    UIButton    *isConcernedButton;
}

@end

@implementation TravelDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self initSubView];
    }
    return self;
}

- (instancetype)init {
    self = [self initWithFrame:CGRectMake(0, 0, kScreenWidth, [[self class] defaultHeight])];
    return self;
}

- (void)initSubView {
    CGFloat avatarImageViewDiameter = 45;
    CGFloat isConcernedButtonWidth = 60;
    CGFloat isConcernedButtonHeight = 25;
    backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:backgroundImageView];
    
    avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kPaddingLeft, self.frameHeight - avatarImageViewDiameter - kPaddingTop, avatarImageViewDiameter, avatarImageViewDiameter)];
    avatarImageView.clipsToBounds = YES;
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    avatarImageView.layer.borderWidth = 2.f;
    avatarImageView.layer.borderColor = UIColorFromHex(0xbbc1c0).CGColor;
    avatarImageView.layer.cornerRadius = avatarImageViewDiameter/2.f;
    [self addSubview:avatarImageView];
    
    isConcernedButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - kPaddingLeft - isConcernedButtonWidth, avatarImageView.frameY - (isConcernedButtonHeight - 17)/2.f, isConcernedButtonWidth, isConcernedButtonHeight)];
    [isConcernedButton setTitle:@"+关注" forState:UIControlStateNormal];
    [isConcernedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    isConcernedButton.titleLabel.font = SystemFont_14;
    [self addSubview:isConcernedButton];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(avatarImageView.maxX + 10, avatarImageView.frameY,isConcernedButton.frameX - avatarImageView.maxY - 10 - 10,17)];
    titleLabel.font = SystemFont_14;
    titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:titleLabel];
    
    subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(avatarImageView.maxX + 10, avatarImageView.maxY - 16,isConcernedButton.frameX - avatarImageView.maxY - 10 - 10, 13.5)];
    subTitleLabel.font = SystemFont_11;
    subTitleLabel.textColor = [UIColor whiteColor];
    [self addSubview:subTitleLabel];
    
}

+ (CGFloat)defaultHeight {
    return 150;
}

- (void)setBackgroundImageURL:(NSString *)backgroundImageURL {
    _backgroundImageURL = backgroundImageURL;
    [backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_backgroundImageURL] placeholderImage:[UIImage imageNamed:@"TravelHeaderViewBG.jpg"]];
}

- (void)setAvatarImageURL:(NSString *)avatarImageURL {
    _avatarImageURL = avatarImageURL;
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:_avatarImageURL] placeholderImage:[UIImage imageNamed:@"TravelHeaderViewBG.jpg"]];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    titleLabel.text = _title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    subTitleLabel.text = _subTitle;
}

- (void)setIsConcerned:(BOOL)isConcerned {
    if (isConcerned) {
        [isConcernedButton setTitle:@"取消关注" forState:UIControlStateNormal];
    }
    else {
        [isConcernedButton setTitle:@"+关注" forState:UIControlStateNormal];
    }
}



@end
