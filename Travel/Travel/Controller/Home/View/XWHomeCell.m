//
//  XWHomeCell.m
//  Demo
//
//  Created by 格式化油条 on 15/7/7.
//  Copyright (c) 2015年 格式化油条. All rights reserved.
//

#import "XWHomeCell.h"
#import "Masonry.h"
#import "XWHomeModel.h"
#import "UIImageView+WebCache.h"
#import "NSDate+SNExtension.h"
#import "XWImageShowView.h"
#import "CommentCell.h"
#import "CommentModel.h"
//#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
@interface XWHomeCell ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView  *headerIntervalView;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) XWImageShowView  *contentDetailViewForImage;   //图片显示1-9张


@property (strong, nonatomic) UIView  *contentDetailView2;
@property (strong, nonatomic) UIView  *contentDetailView3;
@property (strong, nonatomic) UIView  *contentDetailView4;
@property (nonatomic, strong) UITableView *tableView;   //评论用的
@property (nonatomic, strong) NSIndexPath *indexPath;   //评论用的
@property (nonatomic, strong) XWHomeModel *messageModel;


@end

@implementation XWHomeCell

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
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    titleLabel.preferredMaxLayoutWidth = kScreenWidth - 20;
    self.titleLabel = titleLabel;
    
    XWImageShowView *contentDetailViewForImage = [[XWImageShowView alloc]init];
    [self.contentView addSubview:contentDetailViewForImage];
    self.contentDetailViewForImage = contentDetailViewForImage;
    
    //视频
    // 设置imageView的tag，在PlayerView中取（建议设置100以上）
    UIImageView *picView = [[UIImageView alloc]init];
    picView.userInteractionEnabled = YES;
    picView.tag = 101;
    [self.contentView addSubview:picView];
    self.picView = picView;
    
    // 代码添加playerBtn到imageView上
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(0, 0, [UIImage imageNamed:@"video_list_cell_big_icon"].size.width, [UIImage imageNamed:@"video_list_cell_big_icon"].size.height);
    [self.playBtn setImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateNormal];
    [self.playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.picView addSubview:self.playBtn];
    
    //评论
    self.tableView = [[UITableView alloc] init];
    self.tableView.scrollEnabled = NO;
    [self.contentView addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.hyb_lastViewInCell = self.tableView;
//    self.hyb_bottomOffsetToCell = 0.0;
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
        make.top.mas_equalTo(self.headerIntervalView.mas_bottom).offset(20);
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
        make.left.mas_equalTo(self.userLabel.mas_left);
        make.bottom.mas_equalTo(self.avatarImageView.mas_bottom);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_left);
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).offset(20);
    }];
    
    [self.contentDetailViewForImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(padding);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(0);
    }];
    
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentDetailViewForImage.mas_bottom).offset(0);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(0);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([UIImage imageNamed:@"video_list_cell_big_icon"].size.width);
        make.height.mas_equalTo([UIImage imageNamed:@"video_list_cell_big_icon"].size.height);
        make.center.mas_equalTo(self.picView);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(padding);
        make.top.mas_equalTo(self.picView.mas_bottom).offset(padding);
        make.width.mas_equalTo(self.contentView.mas_width).offset(-20);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-magin);
    }];
}

- (void)play:(UIButton *)sender {
    if (self.playBlock) {
        self.playBlock(sender);
    }
}

-(void)commentAction:(UIButton *)sender{
    if (self.CommentBtnClickBlock) {
        self.CommentBtnClickBlock(sender,self.indexPath);
    }
}

/**
 *  设置控件属性
 */
- (void)setFeed:(XWHomeModel *)feed {
    
    _feed = feed;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:feed.avatarURL]];
    self.userLabel.text = feed.username;
    
    self.titleLabel.text = feed.title;
    
    self.timeLabel.text = [NSDate convertDateIntervalToStringWith:[NSString stringWithFormat:@"%lf",feed.timeInterval]];
    
    //图片九宫格
    self.contentDetailViewForImage.imageURLArray = feed.contentImageURLArray;
    
    [self.contentDetailViewForImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([XWImageShowView XWImageShowViewHeightWithImageNumber:feed.contentImageURLArray.count]);
    }];
    
    [self.picView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(self.picView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
        make.height.equalTo(self.picView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    
    //评论
    CGFloat tableViewHeight = 0;
//    for (CommentModel *commentModel in _feed.commentModelArray) {
//        CGFloat cellHeight = [CommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
//            CommentCell *cell = (CommentCell *)sourceCell;
//            [cell configCellWithModel:commentModel];
//        } cache:^NSDictionary *{
//            return @{kHYBCacheUniqueKey : commentModel.commentId,
//                     kHYBCacheStateKey : @"",
//                     kHYBRecalculateForStateKey : @(YES)};
//        }];
//        tableViewHeight += cellHeight;
//    }
//    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tableViewHeight);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }else{
        NSLog(@"Cell 被复用了");
    }

    CommentModel *model = [self.feed.commentModelArray objectAtIndex:indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feed.commentModelArray.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CommentModel *model = [self.feed.commentModelArray objectAtIndex:indexPath.row];
//    CGFloat cell_height = [CommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
//        CommentCell *cell = (CommentCell *)sourceCell;
//        [cell configCellWithModel:model];
//    } cache:^NSDictionary *{
//        NSDictionary *cache = @{kHYBCacheUniqueKey : model.commentId,
//                                kHYBCacheStateKey : @"",
//                                kHYBRecalculateForStateKey : @(NO)};
//        return cache;
//    }];
//    return cell_height;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.indexPath = indexPath;
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    CommentModel *commentModel = [self.feed.commentModelArray objectAtIndex:indexPath.row];
//    CGFloat cell_height = [CommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
//        CommentCell *cell = (CommentCell *)sourceCell;
//
//
//
//        [cell configCellWithModel:commentModel];
//    } cache:^NSDictionary *{
//        NSDictionary *cache = @{kHYBCacheUniqueKey : commentModel.commentId,
//                                kHYBCacheStateKey : @"",
//                                kHYBRecalculateForStateKey : @(NO)};
//        return cache;
//    }];
//
//
//    if ([self.delegate respondsToSelector:@selector(passCellHeightWithMessageModel:commentModel:atCommentIndexPath:cellHeight:commentCell:messageCell:)]) {
////        self.feed.shouldUpdateCache = YES;
//        CommentCell *commetCell =  (CommentCell *)[tableView cellForRowAtIndexPath:indexPath];
//        [self.delegate passCellHeightWithMessageModel:_messageModel commentModel:commentModel atCommentIndexPath:indexPath cellHeight:cell_height commentCell:commetCell messageCell:self];
//    }
//    
//}



@end
