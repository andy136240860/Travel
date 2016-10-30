//
//  TravelTogetherDetailHeaderView.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/26.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Travel.h"
#import "XWSegmentBar.h"

@interface TravelTogetherDetailHeaderView : UIView

@property (nonatomic, strong) XWSegmentBar      *segmentBar;

@property (nonatomic, strong) TravelTogether    *travelTogether;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

+ (CGFloat)defaulHeight;


@end
