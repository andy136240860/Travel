//
//  CUCommentCell.m
//  Bueaty
//
//  Created by zhouzhenhua on 16/4/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "CUCommentCell.h"
#import "CUComment.h"
#import "UIImageView+WebCache.h"
#import "NSDate+SNExtension.h"

#define kImageWidth  30.0

#define kPadding     10.0

#define kContentOriginX  (kPadding + kImageWidth + kPadding)
#define kContentWidth    (kScreenWidth - kContentOriginX * 2)

@interface CUCommentCell ()

@property (nonatomic, strong) CommentDisplayInfo *displayInfo;

@end

@implementation CUCommentCell
{
    UIImageView *imageView;
    UIImageView *imageMask;
    
    UILabel *userLabel;
    UILabel *contentLabel;
    UILabel *dateLabel;
    
    UIImageView *replyTableBg;
    UITableView *replyTable;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews
{
    imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.contentView addSubview:imageView];
    
    imageMask = [[UIImageView alloc] init];
    imageMask.image = [UIImage imageNamed:@"content_head_img"];
    [self.contentView addSubview:imageMask];
    
    dateLabel = [[UILabel alloc] init];
    dateLabel.textColor = kDarkGrayColor;
    dateLabel.font = [UIFont systemFontOfSize:10];
    dateLabel.backgroundColor = self.backgroundColor;
    [self.contentView addSubview:dateLabel];
    
    userLabel = [[UILabel alloc] init];
    userLabel.textColor = kAppStyleColor;
    userLabel.font = [UIFont systemFontOfSize:12];
    userLabel.backgroundColor = self.backgroundColor;
    [self.contentView addSubview:userLabel];
    
    contentLabel = [[UILabel alloc] init];
    contentLabel.textColor = kBlackColor;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = self.backgroundColor;
    [self.contentView addSubview:contentLabel];
    
    _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_replyBtn setTitle:@"回复" forState:UIControlStateNormal];
    [_replyBtn setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    _replyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_replyBtn addTarget:self action:@selector(replyBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_replyBtn];
    
    replyTableBg = [[UIImageView alloc] init];
    replyTableBg.image = [[UIImage imageNamed:@"video_comment_bg"] stretchableImageByCenter];
    [self.contentView addSubview:replyTableBg];
    
    replyTable = [[UITableView alloc] init];
    replyTable.backgroundColor = UIColorFromRGB(247, 248, 249);
    replyTable.scrollEnabled = NO;
    replyTable.scrollsToTop = NO;
    replyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    replyTable.dataSource = (id)self;
    replyTable.delegate = (id)self;
    [self.contentView addSubview:replyTable];
    replyTable.tableFooterView = [[UIView alloc] init];
}

+ (CGFloat)heightWithContent:(NSString *)content
{
    CGFloat contentWidth = kContentWidth;
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(contentWidth, MAXFLOAT)];
    
    return ceilf(size.height);
}

+ (CGFloat)heightWithReplyContent:(NSString *)content
{
    CGFloat contentOriginX = kContentOriginX;
    CGFloat contentWidth = kScreenWidth - contentOriginX - kPadding - 8 * 2;
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(contentWidth, MAXFLOAT)];
    
    return ceilf(size.height);
}

+ (CommentDisplayInfo *)displayWithData:(CUComment *)data
{
    CommentDisplayInfo *info = [[CommentDisplayInfo alloc] init];
    
    info.imageRect = CGRectMake(kPadding, kPadding, kImageWidth, kImageWidth);
    
    CGFloat userOriginX = CGRectGetMaxX(info.imageRect) + 10;
    
    info.userRect = CGRectMake(userOriginX, 13 - 2, kScreenWidth - userOriginX - kPadding, 15);
    
    CGFloat dateWidth = 75.0;
    info.dateRect = CGRectMake(userOriginX, 31 - 1, dateWidth, 12);
    
    CGFloat replyBtnWidth = 45.0;
    CGFloat replyBtnHeight = 36.0;
    info.replyButtonRect = CGRectMake(kScreenWidth - replyBtnWidth, 1, replyBtnWidth, replyBtnHeight);
    
    CGFloat contentOriginX = kContentOriginX;
    CGFloat contentOriginY = kPadding * 2 + kImageWidth;
    CGFloat contentHeight = [self heightWithContent:data.content];
    
    info.contentRect = CGRectMake(contentOriginX, contentOriginY, kScreenWidth - contentOriginX - kPadding, contentHeight);
    
    info.cellHeight = CGRectGetMaxY(info.contentRect) + 15 - 1;
    info.replyTotalHeight = 0;
    info.replyTableBgRect = CGRectZero;
    
    if (data.replyArray.count) {
        CGFloat replyTotalY = CGRectGetMaxY(info.contentRect) + 10 - 1;
        CGFloat replyTotalHeight = 12;
        NSMutableArray *replyArray = [NSMutableArray array];
        for (CUReply *reply in data.replyArray) {
            CGFloat replyHeight = [self heightWithReplyContent:[reply replyContentToComment:data]];
            
            NSValue *value = [NSValue valueWithCGRect:CGRectMake(0, replyTotalY + replyTotalHeight, info.contentRect.size.width, replyHeight)];
            [replyArray addObjectSafely:value];
            
            replyTotalHeight += (replyHeight + 12);
        }
        
        info.replyRects = [replyArray copy];
        info.replyTotalHeight = replyTotalHeight;
        
        info.replyTableBgRect = CGRectMake(contentOriginX, replyTotalY, info.contentRect.size.width, 6 + replyTotalHeight);
        info.cellHeight = CGRectGetMaxY(info.replyTableBgRect) + 15;
    }
    
    return info;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithData:(CUComment *)data cellHeight:(CGFloat)cellHeight
{
    self.data = data;
    
    userLabel.text = data.user.nickName;
    dateLabel.text = [NSDate convertDateIntervalToStringWith:data.commentTimeStamp];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:data.user.avatarURL] placeholderImage:[UIImage imageNamed:@"content_head"]];
    
    contentLabel.text = data.content;
    contentLabel.frameHeight = cellHeight - contentLabel.frameY - 9;
}

- (void)updateWithData:(CUComment *)data displayInfo:(CommentDisplayInfo *)displayInfo
{
    self.data = data;
    self.displayInfo = displayInfo;
    
    imageView.frame = displayInfo.imageRect;
    imageMask.frame = imageView.frame;
    userLabel.frame = displayInfo.userRect;
    contentLabel.frame = displayInfo.contentRect;
    dateLabel.frame = displayInfo.dateRect;
    _replyBtn.frame = displayInfo.replyButtonRect;
    replyTableBg.frame = displayInfo.replyTableBgRect;
    
    userLabel.text = data.user.nickName;
    dateLabel.text = [NSDate convertDateIntervalToStringWith:data.commentTimeStamp];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:data.user.avatarURL] placeholderImage:[UIImage imageNamed:@"content_head"]];
    
    contentLabel.text = data.content;
    
    replyTable.hidden = self.data.replyArray.count ? NO : YES;
    replyTableBg.hidden = replyTable.hidden;
    
    replyTable.frame = CGRectMake(replyTableBg.frame.origin.x + 8, replyTableBg.frame.origin.y + 6, replyTableBg.frame.size.width - 8 * 2, self.displayInfo.replyTotalHeight);
    [replyTable reloadData];
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSValue *rectValue = [self.displayInfo.replyRects objectAtIndexSafely:indexPath.section];
    
    return [rectValue CGRectValue].size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.replyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 12)];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"BeautyReplyCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = replyTable.backgroundColor;
        cell.contentView.backgroundColor = replyTable.backgroundColor;
        
        UILabel *replyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, replyTable.frameWidth, 100)];
        replyLabel.backgroundColor = replyTable.backgroundColor;
        replyLabel.font = [UIFont systemFontOfSize:13];
        replyLabel.textColor = kDarkGrayColor;
        replyLabel.numberOfLines = 0;
        replyLabel.tag = 11;
        [cell.contentView addSubview:replyLabel];
    }
    
    CUReply *reply = [self.data.replyArray objectAtIndexSafely:indexPath.section];
    
    UILabel *replyLabel = [cell.contentView viewWithTag:11];
    replyLabel.hidden = NO;
    replyLabel.attributedText = [reply replyAttrStringToComment:self.data];
    replyLabel.frameHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(didClickCommentCell:toReply:replyRect:)]) {
        NSValue *value = [self.displayInfo.replyRects objectAtIndexSafely:indexPath.section];

        [self.delegate didClickCommentCell:self toReply:[self.data.replyArray objectAtIndexSafely:indexPath.section] replyRect:[value CGRectValue]];
    }
}

- (void)replyBtnPress
{
    if ([self.delegate respondsToSelector:@selector(didClickCommentCell:toReply:replyRect:)]) {
        [self.delegate didClickCommentCell:self toReply:self.data replyRect:self.displayInfo.contentRect];
    }
}

@end
