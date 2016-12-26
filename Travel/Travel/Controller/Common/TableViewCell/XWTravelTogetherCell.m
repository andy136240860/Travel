//
//  XWTravelTogetherCell.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/2.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTravelTogetherCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+SNExtension.h"

@implementation XWTravelTogetherCell
@dynamic detailView;

- (void)createDetailView {
    self.detailView = [[XWTravelTogetherDetailCellView alloc]init];
    self.detailView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.detailView];
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    _travelTogether = travelTogether;
    self.typeImage.image = [UIImage imageNamed:@"together"];
    self.typeLabel.text = @"一起旅行";
    self.detailView.travelTogether = _travelTogether;
}

@end
