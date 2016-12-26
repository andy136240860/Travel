//
//  XWTravelBaseCell.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/1.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTravelBaseCell.h"
#import "Masonry.h"
@interface XWTravelBaseCell()
@property (nonatomic, strong) UIView  *headerIntervalView;
@end

@implementation XWTravelBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createView];
        
        [self createDetailView];
        
        [self setttingViewAtuoLayout];
    }
    
    return self;
}

- (void) createView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *headerIntervalView = [[UIView alloc] init];
    headerIntervalView.backgroundColor = kTableViewGrayColor;
    [self.contentView addSubview:headerIntervalView];
    self.headerIntervalView = headerIntervalView;
    
    UIImageView *avatarImageView = [[UIImageView alloc] init];
    avatarImageView.contentMode = 2;
    avatarImageView.layer.cornerRadius = 17.5f;
    avatarImageView.clipsToBounds = YES;
    [self.contentView addSubview:avatarImageView];
    self.avatarImageView = avatarImageView;
    
    UILabel *userLabel = [[UILabel alloc] init];
    userLabel.font = [UIFont systemFontOfSize:14];
    userLabel.numberOfLines = 1;
    [self.contentView addSubview:userLabel];
    self.userLabel = userLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.numberOfLines = 1;
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    titleLabel.preferredMaxLayoutWidth = kScreenWidth - 20;
    self.titleLabel = titleLabel;
    
    self.typeLabel = [[UILabel alloc]init];
    self.typeLabel.font = [UIFont systemFontOfSize:11];
    self.typeLabel.textColor = kAppStyleColor;
    [self.contentView addSubview:self.typeLabel];
    
    self.typeImage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.typeImage];
    
    self.interactionView = [[XWTravelInteractionCellView alloc]init];
    self.interactionView.commendActionBlock = ^{
    
    };
    self.interactionView.commentActionBlock = ^{
        
    };
    self.interactionView.shareActionBlock = ^{
        
    };
    self.interactionView.moreActionBlock = ^{
        
    };
    [self.contentView addSubview:self.interactionView];
}

- (void)createDetailView {
    self.detailView = [[UIView alloc]init];
    [self.contentView addSubview:self.detailView];
}

#pragma mark - 在此方法内使用 Masonry 设置控件的约束,设置约束不需要在layoutSubviews中设置，只需要在初始化的时候设置
- (void) setttingViewAtuoLayout {
    int magin = 7;
    int padding = 10;
    
    [self.headerIntervalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(padding*2);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerIntervalView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.headerIntervalView.mas_left).offset(padding);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_top);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(padding);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userLabel.mas_left);
        make.bottom.mas_equalTo(self.avatarImageView.mas_bottom);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_left);
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).offset(20);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-padding);
        make.top.mas_equalTo(self.userLabel.mas_top).offset(5);
    }];
    
    [self.typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.typeLabel.mas_left).offset(-5);
        make.top.mas_equalTo(self.typeLabel.mas_top);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
    }];
    
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(magin);
    }];
    
    [self.interactionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.detailView.mas_bottom).with.offset(magin);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
}

@end
