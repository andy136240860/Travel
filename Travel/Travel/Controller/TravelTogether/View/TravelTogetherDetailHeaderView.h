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
#import "TravelTiTleAndDetailView.h"
#import "TravelMatesView.h"
#import "TravelTextAndImageDetailWebView.h"

@interface TravelTogetherDetailHeaderView : UIView

@property (nonatomic, strong) TravelTogether    *travelTogether;

@property (nonatomic, strong) XWSegmentBar      *segmentBar;
@property (nonatomic, strong) TravelTiTleAndDetailView *travelTiTleAndDetailView;
@property (nonatomic, strong) TravelMatesView *travelMatesView;
@property (nonatomic, strong) TravelTextAndImageDetailWebView *travelTextAndImageDetailWebView;

- (instancetype)init;


@end
