//
//  CircularImageViewTableViewCell.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/13.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "CircularImageViewTableViewCell.h"

@implementation CircularImageViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(10, 10, 68, 68);
    self.imageView.layer.cornerRadius = self.imageView.frameHeight/2.f;
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
