//
//  XWHomeCell.h
//  Demo
//
//  Created by 格式化油条 on 15/7/7.
//  Copyright (c) 2015年 格式化油条. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentCell.h"

typedef void(^PlayBtnCallBackBlock)(UIButton *);

@class XWHomeModel;
@class CommentModel;
@class XWHomeCell;

@protocol XWHomeCellDelegate <NSObject>

- (void)reloadCellHeightForModel:(XWHomeModel *)model atIndexPath:(NSIndexPath *)indexPath;
- (void)passCellHeightWithMessageModel:(XWHomeModel *)messageModel commentModel:(CommentModel *)commentModel atCommentIndexPath:(NSIndexPath *)commentIndexPath cellHeight:(CGFloat )cellHeight commentCell:(CommentCell *)commentCell messageCell:(XWHomeCell *)messageCell;
@end

@interface XWHomeCell : UITableViewCell

@property (strong, nonatomic) XWHomeModel *feed;

@property (nonatomic, copy  ) PlayBtnCallBackBlock playBlock;

//视频
@property (nonatomic, strong) UIImageView          *picView;
@property (nonatomic, strong) UIButton             *playBtn;


/**
 *  评论按钮的block
 */
@property (nonatomic, copy)void(^CommentBtnClickBlock)(UIButton *commentBtn,NSIndexPath * indexPath);

/**
 *  更多按钮的block
 */
@property (nonatomic, copy)void(^MoreBtnClickBlock)(UIButton *moreBtn,NSIndexPath * indexPath);


/**
 *  点击图片的block
 */
//@property (nonatomic, copy)TapBlcok tapImageBlock;

/**
 *  点击文字的block
 */

@property (nonatomic, weak) id<XWHomeCellDelegate> delegate;

@end
