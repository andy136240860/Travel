//
//  CUCommentCell.h
//  Bueaty
//
//  Created by zhouzhenhua on 16/4/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentDisplayInfo.h"
#import "CUComment.h"

@protocol CUCommentCellDelegate;

@interface CUCommentCell : UITableViewCell

@property (nonatomic, weak) id<CUCommentCellDelegate> delegate;
@property (nonatomic, strong) CUComment *data;
@property (nonatomic, strong) UIButton *replyBtn;;

- (void)updateWithData:(id)data cellHeight:(CGFloat)cellHeight;
- (void)updateWithData:(id)data displayInfo:(CommentDisplayInfo *)displayInfo;

+ (CGFloat)heightWithContent:(NSString *)content;
+ (CommentDisplayInfo *)displayWithData:(id)data;

@end

@protocol CUCommentCellDelegate <NSObject>

- (void)didClickCommentCell:(CUCommentCell *)cell toReply:(CUComment *)comment replyRect:(CGRect)replyRect;

@end
