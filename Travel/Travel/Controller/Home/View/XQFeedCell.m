//
//  XQFeedCell.m
//  Demo
//
//  Created by 格式化油条 on 15/7/7.
//  Copyright (c) 2015年 格式化油条. All rights reserved.
//

#import "XQFeedCell.h"
#import "Masonry.h"
#import "XQFeedModel.h"
#import "UIImageView+WebCache.h"
#import "NSDate+SNExtension.h"
#import "XWImageShowView.h"
@interface XQFeedCell ()

@property (strong, nonatomic) UIView  *headerIntervalView;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) XWImageShowView  *contentDetailViewForImage;   //图片显示1-9张
@property (strong, nonatomic) UIView  *contentDetailView2;
@property (strong, nonatomic) UIView  *contentDetailView3;
@property (strong, nonatomic) UIView  *contentDetailView4;
@property (strong, nonatomic) UILabel *userLabel;


@end

@implementation XQFeedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createView];
        
        [self setttingViewAtuoLayout];
    }
    
    return self;
}
#pragma make 创建子控件
- (void) createView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *headerIntervalView = [[UIView alloc] init];
    headerIntervalView.backgroundColor = [UIColor grayColor];
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
//    userLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:userLabel];
    self.userLabel = userLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.numberOfLines = 1;
//    timeLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    XWImageShowView *contentDetailViewForImage = [[XWImageShowView alloc]init];
    [self.contentView addSubview:contentDetailViewForImage];
    self.contentDetailViewForImage = contentDetailViewForImage;
}


#pragma mark - 在此方法内使用 Masonry 设置控件的约束,设置约束不需要在layoutSubviews中设置，只需要在初始化的时候设置
- (void) setttingViewAtuoLayout {
    int magin = 7;
    int padding = 10;
    
    [self.headerIntervalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(20);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerIntervalView.mas_bottom).offset(padding);
        make.left.mas_equalTo(self.headerIntervalView.mas_left).offset(padding);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_top);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(padding);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-padding);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userLabel.mas_left);
        make.bottom.mas_equalTo(self.avatarImageView.mas_bottom);
    }];
    
    [self.contentDetailViewForImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).offset(padding);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-magin);
    }];
}

// 如果你是自动布局子控件，就不需要实现此方法，如果是计算子控件frame的话就需要实现此方法
//- (CGSize)sizeThatFits:(CGSize)size {
//    
//    CGFloat cellHeight = 0;
//    
//    cellHeight += [self.titleLabel sizeThatFits:size].height;
//    cellHeight += [self.contentLabel sizeThatFits:size].height;
//    cellHeight += [self.contentImageView sizeThatFits:size].height;
//    cellHeight += [self.userLabel sizeThatFits:size].height;
//    cellHeight += 40;
//    
//    return CGSizeMake(size.width, cellHeight);
//}

/**
 *  设置控件属性
 */
- (void)setFeed:(XQFeedModel *)feed {
    
    _feed = feed;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:feed.avatarURL]];
    self.userLabel.text = feed.username;
    self.userLabel.text = @"14-津-机械-薛玮";
    self.titleLabel.text = feed.title;
    self.timeLabel.text = [NSDate convertDateIntervalToStringWith:feed.timeInterval];
    
    //图片九宫格
    self.contentDetailViewForImage.imageURLArray = feed.contentImageURLArray;
    
    [self.contentDetailViewForImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).offset(10);
        make.width.mas_equalTo([XWImageShowView XWImageShowViewWidth]);
        make.height.mas_equalTo([XWImageShowView XWImageShowViewHeightWithImageNumber:feed.contentImageURLArray.count]);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-4);
    }];
}


@end
