//
//  SNListEmptyView.h
//  CollegeUnion
//
//  Created by li na on 15/6/27.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SNListEmptyType) {
    SNListEmptyTypeNoData         = 0,// 通用空白页
    SNListEmptyTypeDataError      = 1,// 点击重新加载
    SNListEmptyTypeNoSearchResult = 2,// 无搜索结果
    SNListEmptyTypeNoFavorite     = 3,// 无收藏
    SNListEmptyTypeNoComment      = 4,// 无回复我的
    SNListEmptyTypeNoNotice       = 5 // 无消息
};

@protocol SNListEmptyViewDelegate <NSObject>

- (void)emptyViewClicked;

@end

@interface SNListEmptyView : UIView

@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UILabel * textLabel;
@property (nonatomic,strong) UILabel * subTextLabel;
@property (nonatomic,strong) UIButton * actionButton;
@property (nonatomic,assign) id<SNListEmptyViewDelegate> delegate;
@property (nonatomic) SNListEmptyType type;

- (instancetype)initWithFrame:(CGRect)frame;

@end
