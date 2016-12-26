//
//  XWTravelInteractionCellView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/2.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTravelInteractionCellView.h"
#import "Masonry.h"
@interface XWTravelInteractionCellView()
@property (nonatomic,strong) UIButton   *commendButton;
@property (nonatomic,strong) UILabel    *commendNumberLabel;

@property (nonatomic,strong) UIButton   *commentButton;
@property (nonatomic,strong) UILabel    *commentNumberLabel;

@property (nonatomic,strong) UIButton   *shareButton;
@property (nonatomic,strong) UILabel    *shareLabel;

@property (nonatomic,strong) UIButton   *moreButton;
@end

@implementation XWTravelInteractionCellView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubView];
        [self createAutoLayout];
    }
    return self;
}

- (void)initSubView {
    self.commendButton = [[UIButton alloc]init];
    [self.commendButton setImage:[UIImage imageNamed:@"good1"] forState:UIControlStateNormal];
    [self.commendButton addTarget:self action:@selector(commendAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.commendButton];
    
    self.commendNumberLabel = [[UILabel alloc]init];
    self.commendNumberLabel.font = [UIFont systemFontOfSize:10];
    self.commendNumberLabel.textColor = UIColorFromHex(0x666666);
    [self addSubview:self.commendNumberLabel];
    
    self.commentButton = [[UIButton alloc]init];
    [self.commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [self.commentButton addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.commentButton];
    
    self.commentNumberLabel = [[UILabel alloc]init];
    self.commentNumberLabel.font = [UIFont systemFontOfSize:10];
    self.commentNumberLabel.textColor = UIColorFromHex(0x666666);
    [self addSubview:self.commentNumberLabel];
    
    self.shareButton = [[UIButton alloc]init];
    [self.shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shareButton];
    
    self.shareLabel = [[UILabel alloc]init];
    self.shareLabel.font = [UIFont systemFontOfSize:10];
    self.shareLabel.textColor = UIColorFromHex(0x666666);
    self.shareLabel.text = @"分享";
    [self addSubview:self.shareLabel];
    
    self.moreButton = [[UIButton alloc]init];
    [self.moreButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self.moreButton addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.moreButton];
}

- (void)createAutoLayout {
    [self.commendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(8);
        make.left.mas_equalTo(self.mas_left).offset(kPaddingLeft);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-8);
    }];
    [self.commendNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY);
        make.left.mas_equalTo(self.commendButton.mas_right);
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY);
        make.left.mas_equalTo(self.commendNumberLabel.mas_right).offset(kPaddingLeft*3);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
    }];
    [self.commentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY);
        make.left.mas_equalTo(self.commentButton.mas_right);
    }];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY);
        make.left.mas_equalTo(self.commentNumberLabel.mas_right).offset(kPaddingLeft*3);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
    }];
    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY);
        make.left.mas_equalTo(self.shareButton.mas_right);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY);
        make.right.mas_equalTo(self.mas_right).offset(-kPaddingLeft);
    }];
}

- (void)setHasCommend:(BOOL)hasCommend {
    _hasCommend = hasCommend;
    if (_hasCommend) {
        [self.commendButton setImage:[UIImage imageNamed:@"good2"] forState:UIControlStateNormal];
    }
    else {
        [self.commendButton setImage:[UIImage imageNamed:@"good1"] forState:UIControlStateNormal];
    }
}

- (void)setCommendNumber:(NSInteger)commendNumber {
    _commendNumber = commendNumber;
    if (_commendNumber) {
        self.commendNumberLabel.text = [NSString stringWithFormat:@"%ld",_commendNumber];
    }
    else {
        self.commendNumberLabel.text = @"赞";
    }
}

- (void)setCommentNumber:(NSInteger)commentNumber {
    _commentNumber = commentNumber;
    if (_commentNumber) {
        self.commentNumberLabel.text = [NSString stringWithFormat:@"%ld",_commentNumber];
    }
    else {
        self.commentNumberLabel.text = @"评论";
    }
}

- (void)commendAction {
    
}

- (void)commentAction {

}

- (void)shareAction {
    
}

- (void)moreAction {
    
}


@end
