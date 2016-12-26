//
//  XWTravelBaseCell.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/1.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Travel.h"
#import "XWTravelInteractionCellView.h"

@interface XWTravelBaseCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIImageView *typeImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *detailView;

@property (nonatomic, strong) XWTravelInteractionCellView *interactionView;

- (void)createDetailView;
@end
